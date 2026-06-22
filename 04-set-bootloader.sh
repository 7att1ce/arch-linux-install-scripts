DISK="/dev/sda"
ROOT_PARTITION="${DISK}3"
ROOT_PARTUUID=$(blkid -s PARTUUID -o value ${ROOT_PARTITION})

bootctl install && \
bootctl --variables=no --graceful update && \
echo "title   Arch Linux" | tee -a /boot/loader/entries/arch.conf && \
echo "linux   /vmlinuz-linux" | tee -a /boot/loader/entries/arch.conf && \
echo "initrd  /amd-ucode.img" | tee -a /boot/loader/entries/arch.conf && \
echo "initrd  /initramfs-linux.img" | tee -a /boot/loader/entries/arch.conf && \
echo "options root=PARTUUID=${ROOT_PARTUUID} rw" | tee -a /boot/loader/entries/arch.conf && \
echo "title   Arch Linux (dgpu only mode)" | tee -a /boot/loader/entries/arch-dgpu-only.conf && \
echo "linux   /vmlinuz-linux" | tee -a /boot/loader/entries/arch-dgpu-only.conf && \
echo "initrd  /amd-ucode.img" | tee -a /boot/loader/entries/arch-dgpu-only.conf && \
echo "initrd  /initramfs-linux.img" | tee -a /boot/loader/entries/arch-dgpu-only.conf && \
echo "options root=PARTUUID=${ROOT_PARTUUID} rw video=Unknown-1:d" | tee -a /boot/loader/entries/arch-dgpu-only.conf && \
echo "default arch.conf" | tee -a /boot/loader/loader.conf && \
echo "timeout 3" | tee -a /boot/loader/loader.conf && \
bootctl update && \
echo "===== SUCCESS, NEXT: 05-set-sudo.sh ====="
