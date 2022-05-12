#!/bin/bash
echo "=====install firecracker image====="

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# add image
arch=`uname -m`
image_bucket_url="https://s3.amazonaws.com/spec.ccfc.min/img/quickstart_guide/$arch"
wget "${image_bucket_url}/kernels/vmlinux.bin"
wget "${image_bucket_url}/rootfs/bionic.rootfs.ext4"
# firecracker example config
cat <<EOF > vmconfig.json
{
"boot-source": {
    "kernel_image_path": "vmlinux.bin",
    "boot_args": "console=ttyS0 reboot=k panic=1 pci=off"
},
"drives": [
    {
    "drive_id": "rootfs",
    "path_on_host": "bionic.rootfs.ext4",
    "is_root_device": true,
    "is_read_only": false
    }
]
}
EOF
echo "==== firecracker image done ===="
