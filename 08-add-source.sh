wget "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x8b15a6b0e9a3fa35" -O g14.sec && \
sudo pacman-key -a g14.sec && \
sudo pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35 && \
sudo pacman-key --lsign-key 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35 && \
sudo pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35 && \
rm g14.sec && \
sudo cp /etc/pacman.conf /etc/pacman.conf.bak && \
echo "" | sudo tee -a /etc/pacman.conf && \
echo "[g14]" | sudo tee -a /etc/pacman.conf && \
echo "# Server = https://arch.asus-linux.org" | sudo tee -a /etc/pacman.conf && \
echo "Server = https://naru.jhyub.dev/\$repo" | sudo tee -a /etc/pacman.conf && \
sudo sed -i '/\[multilib\]/,/Include = \/etc\/pacman.d\/mirrorlist/ s/^#//' /etc/pacman.conf && \
sudo pacman -Syu && \
echo "===== SUCCESS, NEXT: 09-install-asusctl.sh ====="
