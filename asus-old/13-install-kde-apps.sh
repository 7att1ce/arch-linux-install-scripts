sudo pacman -S --noconfirm --needed noto-fonts noto-fonts-cjk noto-fonts-emoji && \
sudo pacman -S --noconfirm --needed plasma-meta konsole dolphin qt6-multimedia-ffmpeg kwalletmanager && \
sudo pacman -S --noconfirm --needed rog-control-center && \
sudo pacman -S --noconfirm --needed fcitx5-im fcitx5-chinese-addons fcitx5-pinyin-zhwiki && \
sudo pacman -S --noconfirm --needed firefox && \
sudo pacman -S --noconfirm --needed btop && \
sudo systemctl enable plasmalogin && \
echo "===== SUCCESS, RUN [reboot], NEXT: 14-fix.sh ====="
