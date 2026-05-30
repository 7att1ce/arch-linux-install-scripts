git clone https://gitlab.com/asus-linux/nvidia-laptop-power-cfg.git && \
cd nvidia-laptop-power-cfg && \
makepkg -sfi --noconfirm && \
sudo systemctl enable nvidia-suspend.service nvidia-hibernate.service nvidia-resume.service && \
sudo systemctl enable --now nvidia-powerd && \
echo "===== SUCCESS, RUN [reboot], NEXT: 12-install-media.sh ====="
