wipefs --all /dev/nvme0n1

parted /dev/nvme0n1 --script \
    mklabel gpt \
    mkpart "\"EFI System\"" fat32 1MiB 1025MiB \
    set 1 esp on \
    mkpart "\"Linux swap\"" linux-swap 1025MiB 9217MiB \
    mkpart "\"Linux root (x86-64)\"" ext4 9217MiB 100% \
    type 3 4F68BCE3-E8CD-4DB1-96E7-FBCAF984B709
partprobe /dev/nvme0n1
sleep 2

mkfs.fat -F 32 /dev/nvme0n1p1
mkswap /dev/nvme0n1p2
mkfs.ext4 /dev/nvme0n1p3

mount /dev/nvme0n1p3 /mnt
mount --mkdir /dev/nvme0n1p1 /mnt/boot
swapon /dev/nvme0n1p2

cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
curl -L 'https://archlinux.org/mirrorlist/?country=CN&protocol=https' -o /etc/pacman.d/mirrorlist
sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist

cp /etc/pacman.conf /etc/pacman.conf.bak
sed -i '/\[multilib\]/,/Include = \/etc\/pacman.d\/mirrorlist/ s/^#//' /etc/pacman.conf
pacman -Sy

pacstrap -K /mnt \
    base base-devel \
    linux linux-firmware \
    intel-ucode \
    networkmanager modemmanager usb_modeswitch \
    nano vi vim \
    man-db man-pages texinfo \
    sudo bluez bluez-utils wget git openssh \
    tlp tlp-pd tlp-rdw \
    mesa lib32-mesa \
    vulkan-intel lib32-vulkan-intel \
    vulkan-icd-loader lib32-vulkan-icd-loader \
    intel-media-driver \
    libvdpau-va-gl libva-utils \
    vdpauinfo vulkan-tools \
    sof-firmware alsa-firmware \
    alsa-utils \
    pipewire lib32-pipewire wireplumber \
    pipewire-audio pipewire-alsa \
    pipewire-pulse \
    pipewire-jack lib32-pipewire-jack

genfstab -U /mnt | tee -a /mnt/etc/fstab

arch-chroot /mnt

ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc

cp /etc/locale.gen /etc/locale.gen.bak
sed -i '/en_US.UTF-8/s/^#//' /etc/locale.gen
sed -i '/zh_CN.UTF-8/s/^#//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" | tee -a /etc/locale.conf

echo "lenovo" | tee -a /etc/hostname

bootctl install
bootctl --variables=no --graceful update

echo "title   Arch Linux" | tee -a /boot/loader/entries/arch.conf
echo "linux   /vmlinuz-linux" | tee -a /boot/loader/entries/arch.conf
echo "initrd  /intel-ucode.img" | tee -a /boot/loader/entries/arch.conf
echo "initrd  /initramfs-linux.img" | tee -a /boot/loader/entries/arch.conf
echo "options root=PARTUUID=$(blkid -s PARTUUID -o value /dev/nvme0n1p3) rw " | tee -a /boot/loader/entries/arch.conf

echo "default arch.conf" | tee -a /boot/loader/loader.conf
echo "timeout 3" | tee -a /boot/loader/loader.conf
bootctl update

echo "%wheel ALL=(ALL:ALL) ALL" | tee /etc/sudoers.d/user-access
chmod 0440 /etc/sudoers.d/user-access
visudo -c
useradd -m -G wheel user

passwd
passwd user

systemctl enable NetworkManager.service
systemctl enable ModemManager.service
systemctl enable systemd-resolved.service
systemctl enable bluetooth.service
systemctl enable sshd.service
systemctl enable tlp.service
systemctl enable NetworkManager-dispatcher.service
# 该命令在root环境运行有问题，需要修改
systemctl --user enable pipewire pipewire-pulse wireplumber

cp /etc/pacman.conf /etc/pacman.conf.bak
sed -i '/\[multilib\]/,/Include = \/etc\/pacman.d\/mirrorlist/ s/^#//' /etc/pacman.conf

exit
cp /etc/pacman.d/mirrorlist.bak /mnt/etc/pacman.d/
umount -R /mnt
poweroff

sudo pacman -Syu
sudo pacman -S --needed noto-fonts noto-fonts-cjk noto-fonts-emoji
sudo pacman -S --needed plasma-meta konsole dolphin qt6-multimedia-ffmpeg kwalletmanager
sudo pacman -S --needed rog-control-center
sudo pacman -S --needed fcitx5-im fcitx5-chinese-addons fcitx5-pinyin-zhwiki
sudo pacman -S --needed firefox
sudo pacman -S --needed btop
sudo systemctl enable plasmalogin
reboot

sudo pacman -S fuse2
sudo pacman -S unzip 7zip tmux tree firewalld ttf-cascadia-code-nerd krdc libayatana-appindicator
sudo systemctl enable firewalld
sudo ln -sf /usr/lib/qt6/bin/qtpaths /usr/bin/qtpaths
reboot

kwriteconfig6 --file powerdevilrc --group AC --group Display --key DimDisplayIdleTimeoutSec -- -1
kwriteconfig6 --file powerdevilrc --group AC --group Display --key DimDisplayWhenIdle false
kwriteconfig6 --file powerdevilrc --group AC --group Display --key TurnOffDisplayIdleTimeoutSec -- -1
kwriteconfig6 --file powerdevilrc --group AC --group Display --key TurnOffDisplayWhenIdle false
kwriteconfig6 --file powerdevilrc --group AC --group SuspendAndShutdown --key AutoSuspendAction 0
kwriteconfig6 --file powerdevilrc --group AC --group SuspendAndShutdown --key LidAction 0
kwriteconfig6 --file powerdevilrc --group AC --group SuspendAndShutdown --key PowerButtonAction 0
kwriteconfig6 --file powerdevilrc --group Battery --group Display --key DimDisplayIdleTimeoutSec -- -1
kwriteconfig6 --file powerdevilrc --group Battery --group Display --key DimDisplayWhenIdle false
kwriteconfig6 --file powerdevilrc --group Battery --group Display --key TurnOffDisplayIdleTimeoutSec -- -1
kwriteconfig6 --file powerdevilrc --group Battery --group Display --key TurnOffDisplayWhenIdle false
kwriteconfig6 --file powerdevilrc --group Battery --group SuspendAndShutdown --key AutoSuspendAction 0
kwriteconfig6 --file powerdevilrc --group Battery --group SuspendAndShutdown --key LidAction 0
kwriteconfig6 --file powerdevilrc --group Battery --group SuspendAndShutdown --key PowerButtonAction 0
kwriteconfig6 --file powerdevilrc --group BatteryManagement --key BatteryCriticalAction 0
kwriteconfig6 --file powerdevilrc --group LowBattery --group Display --key DimDisplayIdleTimeoutSec -- -1
kwriteconfig6 --file powerdevilrc --group LowBattery --group Display --key DimDisplayWhenIdle false
kwriteconfig6 --file powerdevilrc --group LowBattery --group Display --key TurnOffDisplayIdleTimeoutSec -- -1
kwriteconfig6 --file powerdevilrc --group LowBattery --group Display --key TurnOffDisplayWhenIdle false
kwriteconfig6 --file powerdevilrc --group LowBattery --group Display --key UseProfileSpecificDisplayBrightness false
kwriteconfig6 --file powerdevilrc --group LowBattery --group SuspendAndShutdown --key AutoSuspendAction 0
kwriteconfig6 --file powerdevilrc --group LowBattery --group SuspendAndShutdown --key LidAction 0
kwriteconfig6 --file powerdevilrc --group LowBattery --group SuspendAndShutdown --key PowerButtonAction 0
kwriteconfig6 --file kscreenlockerrc --group Daemon --key Autolock false
kwriteconfig6 --file kscreenlockerrc --group Daemon --key LockGrace 0
kwriteconfig6 --file kscreenlockerrc --group Daemon --key Timeout 0
kwriteconfig6 --file systemsettingsrc --group systemsettings_sidebar_mode --key HighlightNonDefaultSettings true
plasma-apply-lookandfeel --apply org.kde.breezedark.desktop
reboot

