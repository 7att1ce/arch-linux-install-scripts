cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak && \
curl -L 'https://archlinux.org/mirrorlist/?country=CN&protocol=https' -o /etc/pacman.d/mirrorlist && \
sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist && \
pacstrap -K /mnt base base-devel linux linux-firmware amd-ucode networkmanager modemmanager usb_modeswitch nano vi vim man-db man-pages texinfo sudo bluez bluez-utils wget git openssh && \
genfstab -U /mnt | tee -a /mnt/etc/fstab && \
echo "===== SUCCESS, RUN [arch-chroot /mnt], NEXT: 03-set-time.sh ====="
