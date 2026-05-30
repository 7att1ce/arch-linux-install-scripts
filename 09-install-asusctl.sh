sudo pacman -S --noconfirm asusctl power-profiles-daemon python-gobject && \
sudo systemctl enable --now power-profiles-daemon.service && \
echo "===== SUCCESS, RUN [reboot], NEXT: 10-install-gpu-driver.sh ====="
