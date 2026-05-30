wipefs --all /dev/sda && \
parted /dev/sda --script \
    mklabel gpt \
    mkpart "\"EFI System\"" fat32 1MiB 1025MiB \
    set 1 esp on \
    mkpart "\"Linux swap\"" linux-swap 1025MiB 33793MiB \
    mkpart "\"Linux root (x86-64)\"" ext4 33793MiB 100% \
    type 3 4F68BCE3-E8CD-4DB1-96E7-FBCAF984B709 && \
partprobe /dev/sda && \
sleep 2 && \
mkfs.fat -F 32 /dev/sda1 && \
mkswap /dev/sda2 && \
mkfs.ext4 /dev/sda3 && \
mount /dev/sda3 /mnt && \
mount --mkdir /dev/sda1 /mnt/boot && \
swapon /dev/sda2 && \
echo "===== SUCCESS, NEXT: 02-install-essential.sh ====="
