#
## Copyright (C) 2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-rainbow
PKG_VERSION:=2
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/luci-rainbow.git
PKG_SOURCE_VERSION:=5828fadded08e4a15f2cf211c1a42d613743b58c
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Robin Obůrka <robin.oburka@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
PKG_BUILD_DEPENDS:=luci-base/host

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+luci @(PACKAGE_rainbow-omnia||PACKAGE_rainbow)
endef

define Build/Compile
	po2lmo $(PKG_BUILD_DIR)/rainbow.po $(PKG_BUILD_DIR)/rainbow.cs.lmo
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller/rainbow/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/omnia-luasrc/controller/rainbow/rainbow.lua $(1)/usr/lib/lua/luci/controller/rainbow/rainbow.lua

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/rainbow/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/omnia-luasrc/model/cbi/rainbow/rainbow.lua $(1)/usr/lib/lua/luci/model/cbi/rainbow/rainbow.lua

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/rainbow.cs.lmo $(1)/usr/lib/lua/luci/i18n/rainbow.cs.lmo
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
