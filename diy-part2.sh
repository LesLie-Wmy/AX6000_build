#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

echo ${{ github.event.inputs.ip }}
echo $LANIP
export LANIP=${{ github.event.inputs.ip }}
echo $LANIP

# Modify default DNS
sed -i 's/DNS_SERVERS=""/DNS_SERVERS="114.114.114.114"/g' package/network/services/dnsmasq/files/dnsmasq.init

rm -rf ./tmp && rm -rf ./.config*
touch ./.config
cat >> .config <<EOF

#设置设备
CONFIG_TARGET_x86=y
CONFIG_TARGET_x86_64=y
CONFIG_TARGET_x86_64_DEVICE_generic=y

#增加参数
CONFIG_TARGET_ROOTFS_PARTSIZE=2048
CONFIG_TARGET_KERNEL_PARTSIZE=64
CONFIG_TARGET_PER_DEVICE_ROOTFS=y
CONFIG_TARGET_ROOTFS_TARGZ=y

CONFIG_TARGET_ROOTFS_EXT4FS=y
CONFIG_TARGET_EXT4_RESERVED_PCT=0
CONFIG_TARGET_EXT4_BLOCKSIZE_4K=y
CONFIG_TARGET_EXT4_BLOCKSIZE=4096

#删除参数


#增加组件
CONFIG_PACKAGE_ipv6helper=y
CONFIG_PACKAGE_ip6tables-extra=y
CONFIG_PACKAGE_ip6tables-mod-nat=y

#增加主题
#CONFIG_PACKAGE_luci-theme-design=y
#CONFIG_PACKAGE_luci-app-design-config=y

#增加插件
CONFIG_PACKAGE_luci-app-diskman=y
CONFIG_PACKAGE_luci-app-openclash=y
CONFIG_PACKAGE_luci-app-turboacc=y
CONFIG_PACKAGE_luci-app-unblockmusic=y
CONFIG_PACKAGE_luci-app-wrtbwmon=y
CONFIG_PACKAGE_luci-app-aliddns=y
CONFIG_PACKAGE_luci-app-cifs-mount=y
CONFIG_PACKAGE_luci-app-webdav=y
CONFIG_PACKAGE_luci-app-store=y
CONFIG_PACKAGE_luci-app-passwall=y
CONFIG_PACKAGE_luci-app-adguardhome=y

#删除插件
CONFIG_PACKAGE_luci-app-accesscontrol=n
CONFIG_PACKAGE_luci-app-xlnetacc=n
CONFIG_PACKAGE_luci-app-adbyby-plus=n
EOF
