sudo pacman -S --needed --noconfirm \
    nvidia-open nvidia-utils lib32-nvidia-utils \
    mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon \
    vulkan-icd-loader lib32-vulkan-icd-loader && \
echo "===== SUCCESS, RUN [reboot], NEXT: 11-install-powercfg.sh ====="
