set -euxo pipefail

DISK="/dev/nvme0n1"
BOOT_PARTITION="${DISK}p1"
SWAP_PARTITION="${DISK}p2"
ROOT_PARTITION="${DISK}p3"
ROOT_PARTUUID=$(blkid -s PARTUUID -o value ${ROOT_PARTITION})

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
echo "options root=PARTUUID=${ROOT_PARTUUID} rw" | tee -a /boot/loader/entries/arch.conf

echo "default arch.conf" | tee -a /boot/loader/loader.conf
echo "timeout 3" | tee -a /boot/loader/loader.conf
bootctl update

systemctl enable NetworkManager.service
systemctl enable systemd-resolved.service
systemctl enable ModemManager.service
systemctl enable bluetooth.service
systemctl enable tlp.service
systemctl enable NetworkManager-dispatcher.service
systemctl enable sshd.service
systemctl enable firewalld.service
systemctl enable plasmalogin.service

cp /etc/pacman.conf /etc/pacman.conf.bak
sed -i '/\[multilib\]/,/Include = \/etc\/pacman.d\/mirrorlist/ s/^#//' /etc/pacman.conf

pacman -Syu

echo "%wheel ALL=(ALL:ALL) ALL" | tee /etc/sudoers.d/user-access
chmod 0440 /etc/sudoers.d/user-access
visudo -c
useradd -m -G wheel user

echo "========== SUCCESS, RUN [passwd], [passwd user], [exit], [umount -R /mnt], [poweroff], NEXT: 3.sh =========="
