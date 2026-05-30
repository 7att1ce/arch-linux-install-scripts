systemctl enable NetworkManager.service && \
systemctl enable ModemManager.service && \
systemctl enable systemd-resolved.service && \
systemctl enable bluetooth.service && \
systemctl enable sshd.service && \
echo "===== SUCCESS, RUN [exit], NEXT: 07-reboot.sh ====="
