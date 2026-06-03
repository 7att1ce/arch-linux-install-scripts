set -euo pipefail

DISK="/dev/sda"
BOOT_PARTITION="${DISK}1"
SWAP_PARTITION="${DISK}2"
ROOT_PARTITION="${DISK}3"

echo ">>> Erasing disk: ${DISK}..."
wipefs --all ${DISK}

echo ">>> Partitioning disk: ${DISK}..."
parted /dev/sda --script \
    mklabel gpt \
    mkpart "\"EFI System\"" fat32 1MiB 1025MiB \
    set 1 esp on \
    mkpart "\"Linux swap\"" linux-swap 1025MiB 33793MiB \
    mkpart "\"Linux root (x86-64)\"" ext4 33793MiB 100% \
    type 3 4F68BCE3-E8CD-4DB1-96E7-FBCAF984B709
partprobe ${DISK}
sleep 2

echo ">>> Formating disk: ${DISK}..."
mkfs.fat -F 32 ${BOOT_PARTITION}
mkswap ${SWAP_PARTITION}
mkfs.ext4 ${ROOT_PARTITION}

echo ">>> Mounting disk: ${DISK}"
mount ${ROOT_PARTITION} /mnt
mount --mkdir ${BOOT_PARTITION} /mnt/boot
swapon ${SWAP_PARTITION}

echo ">>> Changing pacman mirrorlist to CN..."
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
curl -L 'https://archlinux.org/mirrorlist/?country=CN&protocol=https' -o /etc/pacman.d/mirrorlist
sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist

echo ">>> Installing base packages..."
pacstrap -K /mnt \
    base base-devel \
    linux linux-firmware \
    amd-ucode \
    networkmanager modemmanager usb_modeswitch \
    nano vi vim \
    man-db man-pages texinfo \
    sudo bluez bluez-utils wget git openssh

echo ">>> Generating fstab..."
genfstab -U /mnt | tee -a /mnt/etc/fstab

echo ">>> Entering chroot environment for system configuration..."
cp ./arch-chroot-install.sh /mnt/root
arch-chroot /mnt /root/arch-chroot-install.sh
rm /mnt/root/arch-chroot-install.sh

echo ">>> Preparing to end the installation..."
cp /etc/pacman.d/mirrorlist.bak /mnt/etc/pacman.d/
umount -R /mnt

echo ">>> Installation complete! You need reboot and run 'after-arch-install.sh'."
