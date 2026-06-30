echo "%wheel ALL=(ALL:ALL) ALL" | tee /etc/sudoers.d/user-access && \
chmod 0440 /etc/sudoers.d/user-access && \
visudo -c && \
useradd -m -G wheel user && \
echo "===== SUCCESS, RUN [passwd user], NEXT: 06-enable-service.sh ====="
