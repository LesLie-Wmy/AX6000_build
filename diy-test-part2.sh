# rm -rf $GITHUB_WORKSPACE/openwrt/feeds/packages/lang/golang
# svn export https://github.com/immortalwrt/packages/trunk/lang/golang/ $GITHUB_WORKSPACE/openwrt/feeds/packages/lang/golang
# 更新 golang 1.22 版本
cd $GITHUB_WORKSPACE/openwrt
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 20.x feeds/packages/lang/golang
