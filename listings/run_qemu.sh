#!/bin/sh

RASPBIAN_IMAGE_FILE=raspbian.img

qemu-system-arm \
    -kernel kernel-qemu \
    -cpu arm1176 \
    -m 256 \
    -M versatilepb \
    -no-reboot \
    -serial stdio \
    -append "root=/dev/sda2 panic=1 rootfstype=ext4 rw" \
    -hda ${RASPBIAN_IMAGE_FILE}
