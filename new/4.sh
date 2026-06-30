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

sudo pacman -S --noconfirm --needed \
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

sudo pacman -S --noconfirm --needed \
    libva-nvidia-driver libvdpau-va-gl libva-utils \
    vdpauinfo vulkan-tools
sudo pacman -S --noconfirm --needed \
    sof-firmware alsa-firmware alsa-utils \
    pipewire lib32-pipewire wireplumber \
    pipewire-audio pipewire-alsa pipewire-pulse pipewire-jack lib32-pipewire-jack
systemctl --user enable --now pipewire pipewire-pulse wireplumber
reboot # ==============================================

sudo pacman -S --noconfirm --needed noto-fonts noto-fonts-cjk noto-fonts-emoji
sudo pacman -S --noconfirm --needed plasma-meta konsole dolphin qt6-multimedia-ffmpeg kwalletmanager
sudo pacman -S --noconfirm --needed rog-control-center
sudo pacman -S --noconfirm --needed fcitx5-im fcitx5-chinese-addons fcitx5-pinyin-zhwiki
sudo pacman -S --noconfirm --needed firefox
sudo pacman -S --noconfirm --needed btop
sudo systemctl enable plasmalogin
reboot # ===============================================

sudo pacman -S --noconfirm --needed fuse2
sudo pacman -S --noconfirm --needed unzip 7zip tmux tree firewalld ttf-cascadia-code-nerd krdc libayatana-appindicator
sudo systemctl enable firewalld
sudo ln -sf /usr/lib/qt6/bin/qtpaths /usr/bin/qtpaths
sudo cp /etc/asusd/asusd.ron /etc/asusd/asusd.ron.bak
sudo sed -i 's/platform_profile_on_ac: Performance/platform_profile_on_ac: Quiet/' /etc/asusd/asusd.ron
asusctl aura effect static -c ffffff
# 执行 sudo systemctl restart asusd 会卡住, 原因未知
reboot # ===============================================

kwriteconfig6 --file powerdevilrc --group AC --group Display --key DimDisplayIdleTimeoutSec -- -1
kwriteconfig6 --file powerdevilrc --group AC --group Display --key DimDisplayWhenIdle false
kwriteconfig6 --file powerdevilrc --group AC --group Display --key TurnOffDisplayIdleTimeoutSec -- -1
kwriteconfig6 --file powerdevilrc --group AC --group Display --key TurnOffDisplayWhenIdle false
kwriteconfig6 --file powerdevilrc --group AC --group SuspendAndShutdown --key AutoSuspendAction 0
kwriteconfig6 --file powerdevilrc --group AC --group SuspendAndShutdown --key LidAction 0
kwriteconfig6 --file powerdevilrc --group AC --group SuspendAndShutdown --key PowerButtonAction 0
kwriteconfig6 --file powerdevilrc --group Battery --group Display --key DimDisplayIdleTimeoutSec -- -1
kwriteconfig6 --file powerdevilrc --group Battery --group Display --key DimDisplayWhenIdle false
kwriteconfig6 --file powerdevilrc --group Battery --group Display --key TurnOffDisplayIdleTimeoutSec -- -1
kwriteconfig6 --file powerdevilrc --group Battery --group Display --key TurnOffDisplayWhenIdle false
kwriteconfig6 --file powerdevilrc --group Battery --group SuspendAndShutdown --key AutoSuspendAction 0
kwriteconfig6 --file powerdevilrc --group Battery --group SuspendAndShutdown --key LidAction 0
kwriteconfig6 --file powerdevilrc --group Battery --group SuspendAndShutdown --key PowerButtonAction 0
kwriteconfig6 --file powerdevilrc --group BatteryManagement --key BatteryCriticalAction 0
kwriteconfig6 --file powerdevilrc --group LowBattery --group Display --key DimDisplayIdleTimeoutSec -- -1
kwriteconfig6 --file powerdevilrc --group LowBattery --group Display --key DimDisplayWhenIdle false
kwriteconfig6 --file powerdevilrc --group LowBattery --group Display --key TurnOffDisplayIdleTimeoutSec -- -1
kwriteconfig6 --file powerdevilrc --group LowBattery --group Display --key TurnOffDisplayWhenIdle false
kwriteconfig6 --file powerdevilrc --group LowBattery --group Display --key UseProfileSpecificDisplayBrightness false
kwriteconfig6 --file powerdevilrc --group LowBattery --group SuspendAndShutdown --key AutoSuspendAction 0
kwriteconfig6 --file powerdevilrc --group LowBattery --group SuspendAndShutdown --key LidAction 0
kwriteconfig6 --file powerdevilrc --group LowBattery --group SuspendAndShutdown --key PowerButtonAction 0
kwriteconfig6 --file kscreenlockerrc --group Daemon --key Autolock false
kwriteconfig6 --file kscreenlockerrc --group Daemon --key LockGrace 0
kwriteconfig6 --file kscreenlockerrc --group Daemon --key Timeout 0
kwriteconfig6 --file systemsettingsrc --group systemsettings_sidebar_mode --key HighlightNonDefaultSettings true
plasma-apply-lookandfeel --apply org.kde.breezedark.desktop
