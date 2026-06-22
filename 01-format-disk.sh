DISK="/dev/sda"
BOOT_PARTITION="${DISK}1"
SWAP_PARTITION="${DISK}2"
ROOT_PARTITION="${DISK}3"

wipefs --all ${DISK} && \
parted ${DISK} --script \
    mklabel gpt \
    mkpart "\"EFI System\"" fat32 1MiB 1025MiB \
    set 1 esp on \
    mkpart "\"Linux swap\"" linux-swap 1025MiB 33793MiB \
    mkpart "\"Linux root (x86-64)\"" ext4 33793MiB 100% \
    type 3 4F68BCE3-E8CD-4DB1-96E7-FBCAF984B709 && \
partprobe ${DISK} && \
sleep 2 && \
mkfs.fat -F 32 ${BOOT_PARTITION} && \
mkswap ${SWAP_PARTITION} && \
mkfs.ext4 ${ROOT_PARTITION} && \
mount ${ROOT_PARTITION} /mnt && \
mount --mkdir ${BOOT_PARTITION} /mnt/boot && \
swapon ${SWAP_PARTITION} && \
echo "===== SUCCESS, NEXT: 02-install-essential.sh ====="
