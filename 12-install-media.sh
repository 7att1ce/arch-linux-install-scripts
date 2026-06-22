sudo pacman -S --needed --noconfirm \
    libva-nvidia-driver libvdpau-va-gl libva-utils \
    vdpauinfo vulkan-tools && \
sudo pacman -S --needed --noconfirm \
    sof-firmware alsa-firmware alsa-ucm-conf alsa-utils \
    pipewire lib32-pipewire wireplumber \
    pipewire-audio pipewire-alsa pipewire-pulse pipewire-jack lib32-pipewire-jack && \
systemctl --user enable --now pipewire pipewire-pulse wireplumber && \
echo "===== SUCCESS, RUN [reboot], NEXT: 13-install-kde-apps.sh ====="
