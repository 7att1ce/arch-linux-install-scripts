set -euo pipefail

DISK="/dev/sda"
BOOT_PARTITION="${DISK}1"
SWAP_PARTITION="${DISK}2"
ROOT_PARTITION="${DISK}3"
ROOT_PARTUUID=$(blkid -s PARTUUID -o value ${ROOT_PARTITION})

echo ">>> Setting timezone..."
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc

echo ">>> Setting locale..."
cp /etc/locale.gen /etc/locale.gen.bak
sed -i '/en_US.UTF-8/s/^#//' /etc/locale.gen
sed -i '/zh_CN.UTF-8/s/^#//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" | tee -a /etc/locale.conf

echo ">>> Setting hostname..."
echo "asus" | tee -a /etc/hostname

echo ">>> Setting root password..."
passwd

echo ">>> Installing and Configuring systemd-boot..."
bootctl install
bootctl --variables=no --graceful update

echo "title   Arch Linux" | tee -a /boot/loader/entries/arch.conf
echo "linux   /vmlinuz-linux" | tee -a /boot/loader/entries/arch.conf
echo "initrd  /amd-ucode.img" | tee -a /boot/loader/entries/arch.conf
echo "initrd  /initramfs-linux.img" | tee -a /boot/loader/entries/arch.conf
echo "options root=PARTUUID=${ROOT_PARTUUID} rw" | tee -a /boot/loader/entries/arch.conf

echo "title   Arch Linux (dgpu only mode)" | tee -a /boot/loader/entries/arch-dgpu-only.conf
echo "linux   /vmlinuz-linux" | tee -a /boot/loader/entries/arch-dgpu-only.conf
echo "initrd  /amd-ucode.img" | tee -a /boot/loader/entries/arch-dgpu-only.conf
echo "initrd  /initramfs-linux.img" | tee -a /boot/loader/entries/arch-dgpu-only.conf
echo "options root=PARTUUID=${ROOT_PARTUUID} rw video=Unknown-1:d" | tee -a /boot/loader/entries/arch-dgpu-only.conf

echo "default arch.conf" | tee -a /boot/loader/loader.conf
echo "timeout 3" | tee -a /boot/loader/loader.conf
bootctl update

echo ">>> Adding standard user and configuring sudoers..."
echo "%wheel ALL=(ALL:ALL) ALL" | tee /etc/sudoers.d/user-access
chmod 0440 /etc/sudoers.d/user-access
visudo -c
useradd -m -G wheel user
passwd user

echo ">>> Enabling essential servers..."
systemctl enable NetworkManager.service
systemctl enable ModemManager.service
systemctl enable systemd-resolved.service
systemctl enable bluetooth.service
systemctl enable sshd.service

echo ">>> Adding asus-linux source..."
wget "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x8b15a6b0e9a3fa35" -O g14.sec
pacman-key -a g14.sec
pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
pacman-key --lsign-key 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
rm g14.sec
cp /etc/pacman.conf /etc/pacman.conf.bak
echo "" | tee -a /etc/pacman.conf
echo "[g14]" | tee -a /etc/pacman.conf
echo "# Server = https://arch.asus-linux.org" | tee -a /etc/pacman.conf
echo "Server = https://naru.jhyub.dev/\$repo" | tee -a /etc/pacman.conf
sed -i '/\[multilib\]/,/Include = \/etc\/pacman.d\/mirrorlist/ s/^#//' /etc/pacman.conf
pacman -Syu

echo ">>> Installing asusctl..."
pacman -S --noconfirm asusctl power-profiles-daemon python-gobject
systemctl enable power-profiles-daemon.service

echo ">>> Installing gpu drivers..."
pacman -S --needed --noconfirm \
    nvidia-open nvidia-utils lib32-nvidia-utils \
    mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon \
    vulkan-icd-loader lib32-vulkan-icd-loader

echo ">>> Installing nvidia-laptop-power-cfg..."
su - user -c "git clone https://gitlab.com/asus-linux/nvidia-laptop-power-cfg.git /home/user/nvidia-laptop-power-cfg"
su - user -c "cd /home/user/nvidia-laptop-power-cfg && makepkg -sfi --noconfirm"
systemctl enable nvidia-suspend.service nvidia-hibernate.service nvidia-resume.service
systemctl enable nvidia-powerd
rm -rf /home/user/nvidia-laptop-power-cfg

echo ">>> Installing media components..."
pacman -S --needed --noconfirm \
    libva-nvidia-driver libvdpau-va-gl libva-utils \
    vdpauinfo vulkan-tools
pacman -S --needed --noconfirm \
    sof-firmware alsa-firmware alsa-ucm-conf alsa-utils \
    pipewire lib32-pipewire wireplumber \
    pipewire-audio pipewire-alsa pipewire-pulse pipewire-jack lib32-pipewire-jack
su - user -c "systemctl --user enable pipewire pipewire-pulse wireplumber"

echo ">>> Install desktop environments and common applications..."
pacman -S --needed --noconfirm noto-fonts noto-fonts-cjk noto-fonts-emoji
pacman -S --needed --noconfirm plasma-meta konsole dolphin qt6-multimedia-ffmpeg kwalletmanager
pacman -S --needed --noconfirm rog-control-center
pacman -S --needed --noconfirm fcitx5-im fcitx5-chinese-addons fcitx5-pinyin-zhwiki
pacman -S --needed --noconfirm firefox
pacman -S --needed --noconfirm btop
systemctl enable plasmalogin
