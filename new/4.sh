wget "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x8b15a6b0e9a3fa35" -O g14.sec
sudo pacman-key -a g14.sec
sudo pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
sudo pacman-key --lsign-key 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
sudo pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
rm g14.sec
sudo cp /etc/pacman.conf /etc/pacman.conf.bak
echo "" | sudo tee -a /etc/pacman.conf
echo "[g14]" | sudo tee -a /etc/pacman.conf
echo "# Server = https://arch.asus-linux.org" | sudo tee -a /etc/pacman.conf
echo "Server = https://naru.jhyub.dev/\$repo" | sudo tee -a /etc/pacman.conf
sudo sed -i '/\[multilib\]/,/Include = \/etc\/pacman.d\/mirrorlist/ s/^#//' /etc/pacman.conf
sudo pacman -Syu

sudo pacman -S --noconfirm --needed asusctl power-profiles-daemon python-gobject
sudo systemctl enable --now power-profiles-daemon.service
reboot # ==============================================

sudo pacman -S --needed \
    nvidia-open nvidia-utils lib32-nvidia-utils \
    mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon \
    vulkan-icd-loader lib32-vulkan-icd-loader
reboot # ==============================================

git clone https://gitlab.com/asus-linux/nvidia-laptop-power-cfg.git /home/user/nvidia-laptop-power-cfg
cd /home/user/nvidia-laptop-power-cfg
makepkg -sfi
sudo systemctl enable nvidia-suspend.service nvidia-hibernate.service nvidia-resume.service
sudo systemctl enable --now nvidia-powerd
cd /home/user
rm -rf /home/user/nvidia-laptop-power-cfg
reboot # =============================================

sudo pacman -S --needed \
    libva-nvidia-driver libvdpau-va-gl libva-utils \
    vdpauinfo vulkan-tools
sudo pacman -S --needed \
    sof-firmware alsa-firmware alsa-ucm-conf alsa-utils \
    pipewire lib32-pipewire wireplumber \
    pipewire-audio pipewire-alsa pipewire-pulse pipewire-jack lib32-pipewire-jack
systemctl --user enable --now pipewire pipewire-pulse wireplumber
reboot # ==============================================

sudo pacman -S --needed noto-fonts noto-fonts-cjk noto-fonts-emoji
sudo pacman -S --needed plasma-meta konsole dolphin qt6-multimedia-ffmpeg kwalletmanager
sudo pacman -S --needed rog-control-center
sudo pacman -S --needed fcitx5-im fcitx5-chinese-addons fcitx5-pinyin-zhwiki
sudo pacman -S --needed firefox
sudo pacman -S --needed btop
sudo systemctl enable plasmalogin
reboot # ===============================================

sudo pacman -S fuse2
sudo pacman -S unzip 7zip tmux tree firewalld ttf-cascadia-code-nerd krdc libayatana-appindicator
sudo systemctl enable firewalld
sudo ln -sf /usr/lib/qt6/bin/qtpaths /usr/bin/qtpaths
sudo cp /etc/asusd/asusd.ron /etc/asusd/asusd.ron.bak
sudo sed -i 's/platform_profile_on_ac: Performance/platform_profile_on_ac: Quiet/' /etc/asusd/asusd.ron
asusctl aura effect static -c ffffff
# 执行 sudo systemctl restart asusd 会卡住, 原因未知
reboot # ===============================================

