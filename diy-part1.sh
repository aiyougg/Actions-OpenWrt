#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

#dnsproxy
#git clone --depth 1 --branch master --single-branch --no-checkout https://github.com/muink/luci-app-dnsproxy.git package/luci-app-dnsproxy
#pushd package/luci-app-dnsproxy
#umask 022
#git checkout
#popd

#bandix|argon
#oaf
cd package
#git clone https://github.com/jerrykuku/luci-theme-argon.git
#git clone https://github.com/jerrykuku/luci-app-argon-config.git
git clone https://github.com/destan19/OpenAppFilter.git
git clone https://github.com/timsaya/luci-app-bandix.git
git clone https://github.com/timsaya/openwrt-bandix.git
git clone https://github.com/hudra0/qosmate.git
git clone https://github.com/hudra0/luci-app-qosmate.git
cd ..
