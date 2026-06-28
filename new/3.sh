set -euxo pipefail

cp /etc/pacman.d/mirrorlist.bak /mnt/etc/pacman.d/
umount -R /mnt

echo "========== SUCCESS, RUN [poweroff], NEXT: 4.sh =========="
