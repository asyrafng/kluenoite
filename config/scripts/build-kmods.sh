#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

rpm-ostree install kmod-v4l2loopback

ln -sf /usr/bin/ld.bfd /etc/alternatives/ld && ln -sf /etc/alternatives/ld /usr/bin/ld

KERNEL_NAME='kernel-cachyos-bore-eevdf'
ARCH="$(rpm -E '%_arch')"
KERNEL="$(rpm -q "${KERNEL_NAME}" --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}')"
RELEASE="$(rpm -E '%fedora')"

akmods --force --kernels "${KERNEL}" --kmod v4l2loopback
modinfo /usr/lib/modules/${KERNEL}/extra/wl/wl.ko.xz > /dev/null \
|| (find /var/cache/akmods/wl/ -name \*.log -print -exec cat {} \; && exit 1)
