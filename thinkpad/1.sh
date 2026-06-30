set -euxo pipefail

DISK="/dev/nvme0n1"
BOOT_PARTITION="${DISK}p1"
SWAP_PARTITION="${DISK}p2"
ROOT_PARTITION="${DISK}p3"

wipefs --all ${DISK}

parted ${DISK} --script \
    mklabel gpt \
    mkpart "\"EFI System\"" fat32 1MiB 1025MiB \
    set 1 esp on \
    mkpart "\"Linux swap\"" linux-swap 1025MiB 9217MiB \
    mkpart "\"Linux root (x86-64)\"" ext4 9217MiB 100% \
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

cp /etc/pacman.conf /etc/pacman.conf.bak
sed -i '/\[multilib\]/,/Include = \/etc\/pacman.d\/mirrorlist/ s/^#//' /etc/pacman.conf

pacman -Sy

pacstrap -K /mnt \
    base base-devel linux linux-firmware \
    intel-ucode \
    networkmanager modemmanager usb_modeswitch ppp \
    bluez bluez-utils \
    tlp tlp-pd tlp-rdw \
    mesa lib32-mesa vulkan-intel lib32-vulkan-intel intel-media-driver \
    vulkan-icd-loader lib32-vulkan-icd-loader vulkan-tools \
    libvdpau-va-gl libva-utils vdpauinfo \
    sof-firmware alsa-firmware alsa-utils pipewire lib32-pipewire wireplumber pipewire-audio pipewire-alsa pipewire-pulse pipewire-jack lib32-pipewire-jack \
    sudo nano vi vim man-db man-pages texinfo wget git openssh btop fuse2 unzip 7zip tmux tree firewalld libayatana-appindicator \
    noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-cascadia-code-nerd \
    plasma-meta konsole dolphin qt6-multimedia-ffmpeg kwalletmanager krdc firefox \
    fcitx5-im fcitx5-chinese-addons fcitx5-pinyin-zhwiki

genfstab -U /mnt | tee -a /mnt/etc/fstab

cp /etc/pacman.d/mirrorlist.bak /mnt/etc/pacman.d/

echo "========== SUCCESS, RUN [arch-chroot /mnt], NEXT: 2.sh =========="
