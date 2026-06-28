set -euxo pipefail

DISK="/dev/nvme1n1"
BOOT_PARTITION="${DISK}p1"
SWAP_PARTITION="${DISK}p2"
ROOT_PARTITION="${DISK}p3"

wipefs --all ${DISK}
parted ${DISK} --script \
    mklabel gpt \
    mkpart "\"EFI System\"" fat32 1MiB 1025MiB \
    set 1 esp on \
    mkpart "\"Linux swap\"" linux-swap 1025MiB 33793MiB \
    mkpart "\"Linux root (x86-64)\"" ext4 33793MiB 100% \
    type 3 4F68BCE3-E8CD-4DB1-96E7-FBCAF984B709
partprobe ${DISK}
sleep 2

mkfs.fat -F 32 ${BOOT_PARTITION}
mkswap ${SWAP_PARTITION}
mkfs.ext4 ${ROOT_PARTITION}

mount ${ROOT_PARTITION} /mnt
mount --mkdir ${BOOT_PARTITION} /mnt/boot
swapon ${SWAP_PARTITION}

cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
curl -L 'https://archlinux.org/mirrorlist/?country=CN&protocol=https' -o /etc/pacman.d/mirrorlist
sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist

pacstrap -K /mnt \
    base base-devel \
    linux linux-firmware \
    amd-ucode \
    networkmanager modemmanager usb_modeswitch \
    nano vi vim \
    man-db man-pages texinfo \
    sudo bluez bluez-utils wget git openssh

genfstab -U /mnt | tee -a /mnt/etc/fstab

echo "========== SUCCESS, RUN [arch-chroot /mnt], NEXT: 2.sh =========="
