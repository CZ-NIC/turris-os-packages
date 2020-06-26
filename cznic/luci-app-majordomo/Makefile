#
## Copyright (C) 2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-majordomo
PKG_VERSION:=3
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/luci-majordomo.git
PKG_SOURCE_VERSION:=8e925c378dc6fc33582c1a885432cc5e439bbb17
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Robin Obůrka <robin.oburka@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
PKG_BUILD_DEPENDS:=luci-base/host

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+luci +lcollect-majordomo
endef

define Build/Compile
	po2lmo $(PKG_BUILD_DIR)/majordomo.po $(PKG_BUILD_DIR)/majordomo.cs.lmo
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller/majordomo/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/luasrc/controller/majordomo/majordomo.lua $(1)/usr/lib/lua/luci/controller/majordomo/majordomo.lua

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/majordomo/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/luasrc/model/cbi/majordomo/settings.lua $(1)/usr/lib/lua/luci/model/cbi/majordomo/settings.lua

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/majordomo/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/luasrc/view/majordomo/details.htm $(1)/usr/lib/lua/luci/view/majordomo/details.htm
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/luasrc/view/majordomo/index.htm $(1)/usr/lib/lua/luci/view/majordomo/index.htm

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/majordomo.cs.lmo $(1)/usr/lib/lua/luci/i18n/majordomo.cs.lmo
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
