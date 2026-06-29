    1  ln -sf /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime
    2  hwclock --systohc
    3  cp /etc/locale.gen /etc/locale.gen.bak
    4  nano /etc/locale.gen
    5  locale-gen 
    6  echo "LANG=en_US.UTF-8" | tee -a /etc/locale.conf
    7  echo "lenovo" | tee -a /etc/hostname
    8  passwd
    9  bootctl install
   10  bootctl --variables=no --graceful update
   11  nano /boot/loader/entries/arch.conf
   12  cat /boot/loader/entries/arch.conf 
   13  ls /boot/
   14  echo "options root=PARTUUID=$(blkid -s PARTUUID -o value /dev/nvme0n1p3) rw" | tee -a /boot/loader/entries/arch.conf 
   15  cat /boot/loader/entries/arch.conf 
   16  nano /boot/loader/loader.conf 
   17  cat /boot/loader/loader.conf 
   18  bootctl update
   19  echo "%wheel ALL=(ALL:ALL) ALL" | tee -a /etc/sudoers.d/user-access
   20  chmod 0440 /etc/sudoers.d/user-access 
   21  visudo -c
   22  cat /etc/sudoers.d/user-access 
   23  useradd -m -G wheel user
   24  passwd user
   25  passwd user
   26  systemctl enable NetworkManager.service
   27  systemctl enable ModemManager.service systemd-resolved.service bluetooth.service sshd.service
   28  exit
   29  ls
   30  cd ~
   31  ls
   32  ls -a
   33  history >> /home/user/arch-chroot.sh
