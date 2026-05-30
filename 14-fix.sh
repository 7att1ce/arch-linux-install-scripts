sudo pacman -S --noconfirm fuse2 && \
sudo ln -sf /usr/lib/qt6/bin/qtpaths /usr/bin/qtpaths && \
sudo cp /etc/asusd/asusd.ron /etc/asusd/asusd.ron.bak && \
sudo sed -i 's/platform_profile_on_ac: Performance/platform_profile_on_ac: Quiet/' /etc/asusd/asusd.ron && \
asusctl aura effect static -c ffffff && \
echo "===== SUCCESS, RUN [reboot], FINISHED ====="
