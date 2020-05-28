#
## Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=updater-opkg-wrapper
PKG_VERSION:=0.1.1
PKG_RELEASE:=1
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/updater/opkg-wrapper.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/updater-opkg-wrapper
	TITLE:=OPKG compatibility wrapper for next generation updater
	DEPENDS:=+opkg +updater-ng +localrepo
endef

define Package/updater-opkg-wrapper/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/opkg $(1)/usr/bin/opkg-pkgupdate-wrapper.sh
	$(INSTALL_DIR) $(1)/etc/updater/conf.d
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/opkg.lua $(1)/etc/updater/conf.d/opkg.lua
	$(INSTALL_DIR) $(1)/etc/updater/opkg-ignore
	touch $(1)/etc/updater/opkg-ignore/.keep
endef

Build/Compile:=

$(eval $(call BuildPackage,updater-opkg-wrapper))
