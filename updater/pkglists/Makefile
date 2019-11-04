#
## Copyright (C) 2016-2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=pkglists
PKG_VERSION:=1.3
PKG_RELEASE:=1
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  TITLE:=Packages lists for the updater
  DEPENDS:=+updater-ng +json4lua +libuci-lua
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/share/updater/
	$(INSTALL_DATA) ./files/definitions.json $(1)/usr/share/updater/pkglists.json

	$(INSTALL_DIR) $(1)/etc/config $(1)/etc/updater/conf.d
	$(INSTALL_CONF) ./files/pkglists.uci $(1)/etc/config/pkglists
	$(INSTALL_DATA) ./files/updater.lua $(1)/etc/updater/conf.d/turris-pkglists.lua
endef

Build/Compile:=:

$(eval $(call BuildPackage,$(PKG_NAME)))
