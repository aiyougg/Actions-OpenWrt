#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
git clone https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

#oaf
git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

#dnsproxy
git clone --depth 1 --branch master --single-branch --no-checkout https://github.com/muink/luci-app-dnsproxy.git package/luci-app-dnsproxy
pushd package/luci-app-dnsproxy
umask 022
git checkout
popd
