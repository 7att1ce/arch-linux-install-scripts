ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
hwclock --systohc && \
cp /etc/locale.gen /etc/locale.gen.bak && \
sed -i '/en_US.UTF-8/s/^#//' /etc/locale.gen && \
sed -i '/zh_CN.UTF-8/s/^#//' /etc/locale.gen && \
locale-gen && \
echo "LANG=en_US.UTF-8" | tee -a /etc/locale.conf && \
echo "asus" | tee -a /etc/hostname && \
echo "===== SUCCESS, RUN [passwd], NEXT: 04-set-bootloader.sh ====="
