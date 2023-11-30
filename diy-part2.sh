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

# Modify default DNS
sed -i 's/DNS_SERVERS=""/DNS_SERVERS="114.114.114.114"/g' package/network/services/dnsmasq/files/dnsmasq.init


##
rm -rf ./feeds/extraipk/theme/luci-theme-argon-18.06
rm -rf ./feeds/extraipk/theme/luci-app-argon-config-18.06
rm -rf ./feeds/extraipk/theme/luci-theme-design
rm -rf ./feeds/extraipk/theme/luci-theme-edge
rm -rf ./feeds/extraipk/theme/luci-theme-ifit
rm -rf ./feeds/extraipk/theme/luci-theme-opentopd
rm -rf ./feeds/extraipk/theme/luci-theme-neobird

rm -rf ./package/feeds/extraipk/luci-theme-argon-18.06
rm -rf ./package/feeds/extraipk/luci-app-argon-config-18.06
rm -rf ./package/feeds/extraipk/theme/luci-theme-design
rm -rf ./package/feeds/extraipk/theme/luci-theme-edge
rm -rf ./package/feeds/extraipk/theme/luci-theme-ifit
rm -rf ./package/feeds/extraipk/theme/luci-theme-opentopd
rm -rf ./package/feeds/extraipk/theme/luci-theme-neobird


##取消bootstrap为默认主题
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-nginx/Makefile

##更改主机名
sed -i "s/hostname='.*'/hostname='OpenWRT'/g" package/base-files/files/bin/config_generate

##加入作者信息
sed -i "s/DISTRIB_DESCRIPTION='*.*'/DISTRIB_DESCRIPTION='OpenWRT-$(date +%Y%m%d)'/g"  package/base-files/files/etc/openwrt_release
sed -i "s/DISTRIB_REVISION='*.*'/DISTRIB_REVISION=' By LesLie.W'/g" package/base-files/files/etc/openwrt_release
cp -af feeds/extraipk/patch/diy/banner-easy  package/base-files/files/etc/banner

sed -i "2iuci set istore.istore.channel='leslie_w'" package/emortal/default-settings/files/99-default-settings
sed -i "3iuci commit istore" package/emortal/default-settings/files/99-default-settings


##FQ全部调到VPN菜单
# sed -i 's/services/vpn/g' package/feeds/luci/luci-app-ssr-plus/luasrc/controller/*.lua
# sed -i 's/services/vpn/g' package/feeds/luci/luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/*.lua
# sed -i 's/services/vpn/g' package/feeds/luci/luci-app-ssr-plus/luasrc/view/shadowsocksr/*.htm

# sed -i 's/services/vpn/g' package/feeds/luci/luci-app-passwall/luasrc/controller/*.lua
# sed -i 's/services/vpn/g' package/feeds/luci/luci-app-passwall/luasrc/passwall/*.lua
# sed -i 's/services/vpn/g' package/feeds/luci/luci-app-passwall/luasrc/model/cbi/passwall/client/*.lua
# sed -i 's/services/vpn/g' package/feeds/luci/luci-app-passwall/luasrc/model/cbi/passwall/server/*.lua
# sed -i 's/services/vpn/g' package/feeds/luci/luci-app-passwall/luasrc/view/passwall/app_update/*.htm
# sed -i 's/services/vpn/g' package/feeds/luci/luci-app-passwall/luasrc/view/passwall/socks_auto_switch/*.htm
# sed -i 's/services/vpn/g' package/feeds/luci/luci-app-passwall/luasrc/view/passwall/global/*.htm
# sed -i 's/services/vpn/g' package/feeds/luci/luci-app-passwall/luasrc/view/passwall/haproxy/*.htm
# sed -i 's/services/vpn/g' package/feeds/luci/luci-app-passwall/luasrc/view/passwall/log/*.htm
# sed -i 's/services/vpn/g' package/feeds/luci/luci-app-passwall/luasrc/view/passwall/node_list/*.htm
# sed -i 's/services/vpn/g' package/feeds/luci/luci-app-passwall/luasrc/view/passwall/rule/*.htm
# sed -i 's/services/vpn/g' package/feeds/luci/luci-app-passwall/luasrc/view/passwall/server/*.htm

# sed -i 's/services/vpn/g' package/feeds/extraipk/luci-app-passwall2/luasrc/controller/*.lua
# sed -i 's/services/vpn/g' package/feeds/extraipk/luci-app-passwall2/luasrc/passwall2/*.lua
# sed -i 's/services/vpn/g' package/feeds/extraipk/luci-app-passwall2/luasrc/model/cbi/passwall2/client/*.lua
# sed -i 's/services/vpn/g' package/feeds/extraipk/luci-app-passwall2/luasrc/model/cbi/passwall2/server/*.lua
# sed -i 's/services/vpn/g' package/feeds/extraipk/luci-app-passwall2/luasrc/view/passwall2/app_update/*.htm
# sed -i 's/services/vpn/g' package/feeds/extraipk/luci-app-passwall2/luasrc/view/passwall2/socks_auto_switch/*.htm
# sed -i 's/services/vpn/g' package/feeds/extraipk/luci-app-passwall2/luasrc/view/passwall2/global/*.htm
# sed -i 's/services/vpn/g' package/feeds/extraipk/luci-app-passwall2/luasrc/view/passwall2/haproxy/*.htm
# sed -i 's/services/vpn/g' package/feeds/extraipk/luci-app-passwall2/luasrc/view/passwall2/log/*.htm
# sed -i 's/services/vpn/g' package/feeds/extraipk/luci-app-passwall2/luasrc/view/passwall2/node_list/*.htm
# sed -i 's/services/vpn/g' package/feeds/extraipk/luci-app-passwall2/luasrc/view/passwall2/rule/*.htm
# sed -i 's/services/vpn/g' package/feeds/extraipk/luci-app-passwall2/luasrc/view/passwall2/server/*.htm

# sed -i 's/services/vpn/g' package/feeds/luci/luci-app-vssr/luasrc/controller/*.lua
# sed -i 's/services/vpn/g' package/feeds/luci/luci-app-vssr/luasrc/model/cbi/vssr/*.lua
# sed -i 's/services/vpn/g' package/feeds/luci/luci-app-vssr/luasrc/view/vssr/*.htm

# sed -i 's/services/vpn/g' package/feeds/luci/luci-app-openclash/luasrc/controller/*.lua
# sed -i 's/services/vpn/g' package/feeds/luci/luci-app-openclash/luasrc/*.lua
# sed -i 's/services/vpn/g' package/feeds/luci/luci-app-openclash/luasrc/model/cbi/openclash/*.lua
# sed -i 's/services/vpn/g' package/feeds/luci/luci-app-openclash/luasrc/view/openclash/*.htm

# sed -i 's/services/vpn/g' package/feeds/extraipk/luci-app-bypass/luasrc/controller/*.lua
# sed -i 's/services/vpn/g' package/feeds/extraipk/luci-app-bypass/luasrc/model/cbi/bypass/*.lua
# sed -i 's/services/vpn/g' package/feeds/extraipk/luci-app-bypass/luasrc/view/bypass/*.htm

