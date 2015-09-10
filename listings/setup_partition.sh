#!/bin/sh

RASPBIAN_IMAGE_FILE=raspbian.img
MOUNT_PATH=/mnt/loop0p2

# Mount the partition
kpartx -av ${RASPBIAN_IMAGE_FILE}
mkdir -v ${MOUNT_PATH} 2> /dev/null
mount /dev/mapper/loop0p2 ${MOUNT_PATH}

# Disable libcofi_rpi.so
# Comment "/usr/lib/arm-linux-gnueabihf/libcofi_rpi.so" in "${MOUNT_PATH}/etc/ld.so.preload"
sed -ri "s/^.*libcofi_rpi.so/#\0/g" ${MOUNT_PATH}/etc/ld.so.preload

# Fix partition names
cat << 'EOF' >> ${MOUNT_PATH}/etc/udev/rules.d/90-qemu.rules
KERNEL=="sda", SYMLINK+="mmcblk0"
KERNEL=="sda?", SYMLINK+="mmcblk0p%n"
KERNEL=="sda2", SYMLINK+="root"
EOF

# Umount the partition
umount ${MOUNT_PATH}
kpartx -d ${RASPBIAN_IMAGE_FILE}

