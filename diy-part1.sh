#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >> feeds.conf.default
echo 'src-git small https://github.com/kenzok8/small' >> feeds.conf.default

cd ./package

export CORE_VER=https://raw.githubusercontent.com/vernesong/OpenClash/core/dev/core_version
export CORE_TUN=https://github.com/vernesong/OpenClash/raw/core/dev/premium/clash-linux-amd64
export CORE_DEV=https://github.com/vernesong/OpenClash/raw/core/dev/dev/clash-linux-amd64.tar.gz
export CORE_MATE=https://github.com/vernesong/OpenClash/raw/core/dev/meta/clash-linux-amd64.tar.gz

#OpenClash
git clone --depth=1 --single-branch --branch "dev" https://github.com/vernesong/OpenClash.git

#OpenClash Core
cd ./OpenClash/luci-app-openclash/root/etc/openclash
mkdir ./core && cd ./core
export TUN_VER=$(curl -s $CORE_VER | sed -n "2p")
curl -SsL -o ./tun.gz $CORE_TUN-$TUN_VER.gz
gzip -d ./tun.gz
mv ./tun ./clash_tun
curl -SsL -o ./meta.tar.gz $CORE_MATE
tar -zxf ./meta.tar.gz
mv ./clash ./clash_meta
curl -SsL -o ./dev.tar.gz $CORE_DEV
tar -zxf ./dev.tar.gz
chmod +x ./clash*
rm -rf ./*.gz
