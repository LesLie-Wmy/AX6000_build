#!/bin/bash

#修改默认主题
sed -i "s/luci-theme-bootstrap/luci-theme-argon/g" $(find ./feeds/luci/collections/ -type f -name "Makefile")
#修改immortalwrt.lan关联IP
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.1.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
#添加编译日期标识
#sed -i "s/(\(luciversion || ''\))/(\1) + (' \/ $WRT_MARK-$WRT_DATE')/g" $(find ./feeds/luci/modules/luci-mod-status/ -type f -name "10_system.js")

WIFI_FILE="./package/mtk/applications/mtwifi-cfg/files/mtwifi.sh"
#修改WIFI名称
sed -i "s/ImmortalWrt/MyWiFi/g" $WIFI_FILE
#修改WIFI加密
sed -i "s/encryption=.*/encryption='psk2+ccmp'/g" $WIFI_FILE
#修改WIFI密码
sed -i "/set wireless.default_\${dev}.encryption='psk2+ccmp'/a \\\t\t\t\t\t\set wireless.default_\${dev}.key='$WRT_WORD'" $WIFI_FILE

CFG_FILE="./package/base-files/files/bin/config_generate"
#修改默认IP地址
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.1.1/g" $CFG_FILE
#修改默认主机名
sed -i "s/hostname='.*'/hostname='AX6000'/g" $CFG_FILE

#配置文件修改
echo "CONFIG_PACKAGE_luci=y" >> ./.config
echo "CONFIG_LUCI_LANG_zh_Hans=y" >> ./.config
echo "CONFIG_PACKAGE_luci-theme-argon=y" >> ./.config
echo "CONFIG_PACKAGE_luci-app-argon-config=y" >> ./.config
echo "CONFIG_TARGET_OPTIONS=y" >> ./.config
echo "CONFIG_TARGET_OPTIMIZATION=\"-O2 -pipe -march=armv8-a+crypto+crc -mcpu=cortex-a53+crypto+crc -mtune=cortex-a53\"" >> ./.config

#手动调整的插件
# if [ -n "$WRT_PACKAGE" ]; then
# 	echo -e "$WRT_PACKAGE" >> ./.config
# fi

#调整mtk系列配置
sed -i '/MEMORY_SHRINK/d' ./.config
sed -i '/luci-app-mtk/d' ./.config
sed -i '/wifi-profile/d' ./.config
echo "CONFIG_PACKAGE_luci-app-mtk=n" >> ./.config
echo "CONFIG_PACKAGE_wifi-profile=n" >> ./.config
