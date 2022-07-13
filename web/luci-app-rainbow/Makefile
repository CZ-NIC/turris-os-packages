#
## Copyright (C) 2015-2020 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-rainbow
PKG_VERSION:=2.1
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/luci-rainbow.git
PKG_MIRROR_HASH:=f9a8ec872bf5159ace837d44928285eebca443f27cafd926b929c26bdc6f851c
PKG_SOURCE_VERSION:=7f11144cd32ad8c0c96cf2b69910ba63b3ef7d63


PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-2.0-or-later

PKG_BUILD_DEPENDS:=luci-base/host

include $(INCLUDE_DIR)/package.mk

ifdef CONFIG_TARGET_mvebu_cortexa9_DEVICE_cznic_turris-omnia
BOARD=omnia
else
BOARD=turris
endif

define Package/luci-app-rainbow
  TITLE:=luci-app-rainbow
  URL:=https://gitlab.nic.cz/turris/luci-rainbow
  DEPENDS:=+luci +luci-compat +turris-rainbow
endef

define Build/Compile
	po2lmo $(PKG_BUILD_DIR)/rainbow.po $(PKG_BUILD_DIR)/rainbow.cs.lmo
endef

define Package/luci-app-rainbow/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller/rainbow/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/$(BOARD)-luasrc/controller/rainbow/rainbow.lua $(1)/usr/lib/lua/luci/controller/rainbow/rainbow.lua

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/rainbow/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/$(BOARD)-luasrc/model/cbi/rainbow/rainbow.lua $(1)/usr/lib/lua/luci/model/cbi/rainbow/rainbow.lua

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/rainbow.cs.lmo $(1)/usr/lib/lua/luci/i18n/rainbow.cs.lmo
endef

$(eval $(call BuildPackage,luci-app-rainbow))
