    1  sudo cp /etc/pacman.conf /etc/pacman.conf.bak
    2  sudo nano /etc/pacman.conf
    3  sudo pacman -Syu
    4  sudo pacman -S --needed tlp
    5  sudo systemctl enable tlp.service
    6  sudo pacman -S --needed tlp-pd
    7  history
    8  sudo pacman -S --needed tlp-rdw
    9  sudo systemctl enable NetworkManager-dispacher.service
   10  sudo systemctl enable NetworkManager-dispatcher.service
   11  reboot
   12  sudo pacman -S --needed mesa lib32-mesa vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader intel-media-driver libva-intel-driver linux-firmware-intel \
   13  sudo pacman -S --needed mesa lib32-mesa vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader intel-media-driver linux-firmware-intel libvdpau-va-gl libva-utils vdpauinfp vulkan-tools \
   14  sudo pacman -S --needed \mesa lib32-mesa vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader intel-media-driver linux-firmware-intel libvdpau-va-gl libva-utils vdpauinfo vulkan-tools \
   15  sudo pacman -S --needed mesa lib32-mesa vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader intel-media-driver linux-firmware-intel libvdpau-va-gl libva-utils vdpauinfo vulkan-tools sof firmware alsa-firmware wireplumber pipewire lib32-pipewire wireplumber \
   16  sudo pacman -S --needed mesa lib32-mesa vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader intel-media-driver linux-firmware-intel libvdpau-va-gl libva-utils vdpauinfo vulkan-tools sof-firmware alsa-firmware alsa-ucm-conf alsa-utils pipewire lib32-pipewire wireplumber pipewire-audio pipewire-alsa pipewire-pulse pipewire-jack lib32-pipewire-jack
   17  systemctl --user enable pipewire pipewire-pulse wireplumber
   18  reboot
   19  curl 192.168.10.4/1.sh
   20  curl 192.168.10.4:8080/1.sh
   21  curl 192.168.10.4:8080/1.sh | bash
   22  curl 192.168.10.4:8080/1.sh
   23  curl 192.168.10.4:8080/1.sh | bash
   24  reboot
   25  curl 192.168.10.4:8080/2.sh
   26  curl 192.168.10.4:8080/2.sh | bash
   27  reboot
   28  curl 192.168.10.4:8080/3.sh
   29  curl 192.168.10.4:8080/3.sh | bash
   30  reboot
   31  sudo nano /etc/tlp.conf 
   32  exit
   33  history >> install.sh
