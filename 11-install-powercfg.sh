git clone https://gitlab.com/asus-linux/nvidia-laptop-power-cfg.git /home/user/nvidia-laptop-power-cfg && \
cd /home/user/nvidia-laptop-power-cfg && \
makepkg -sfi --noconfirm && \
sudo systemctl enable nvidia-suspend.service nvidia-hibernate.service nvidia-resume.service && \
sudo systemctl enable --now nvidia-powerd && \
cd /home/user && \
rm -rf /home/user/nvidia-laptop-power-cfg && \
echo "===== SUCCESS, RUN [reboot], NEXT: 12-install-media.sh ====="
