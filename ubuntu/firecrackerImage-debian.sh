#!/bin/bash
echo "=====install firecracker image====="

DEFAULT_FC_PATH=${1:-"/opt/firecracker"}

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi
mkdir -p "${DEFAULT_FC_PATH}/"{data,config,snakesandsparklers}
mkdir -p ${DEFAULT_FC_PATH}/data/{kernels,disks}
# add image
arch=`uname -m`
image_bucket_url="https://s3.amazonaws.com/spec.ccfc.min/img/quickstart_guide/$arch"
wget -P ${DEFAULT_FC_PATH}/data/kernels/ "${image_bucket_url}/kernels/vmlinux.bin"
wget -P ${DEFAULT_FC_PATH}/data/disks/ "${image_bucket_url}/rootfs/bionic.rootfs.ext4"
# firecracker example config
cat <<EOF > ${DEFAULT_FC_PATH}/config/vmconfig.json
{
"boot-source": {
    "kernel_image_path": "${DEFAULT_FC_PATH}/data/kernels/vmlinux.bin",
    "boot_args": "console=ttyS0 reboot=k panic=1 pci=off"
},
"drives": [
    {
    "drive_id": "rootfs",
    "path_on_host": "${DEFAULT_FC_PATH}/data/disks/bionic.rootfs.ext4",
    "is_root_device": true,
    "is_read_only": false
    }
]
}
EOF
echo "==== firecracker image done ===="
