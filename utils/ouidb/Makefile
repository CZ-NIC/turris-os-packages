#
## Copyright (C) 2013-2020 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=ouidb
PKG_VERSION:=4
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/ouidb.git
PKG_SOURCE_VERSION:=ca0ecbb2e89a21d22ec0613e3447959d5d36499c

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/ouidb
	TITLE:=ouidb
endef

Build/Compile:=:

define Package/ouidb/install
	$(INSTALL_DIR) $(1)/usr/share/ouidb/
	$(INSTALL_DIR) $(1)/usr/bin/

	$(INSTALL_BIN) $(PKG_BUILD_DIR)/ouidb $(1)/usr/bin/

	$(INSTALL_DATA) $(PKG_BUILD_DIR)/oui.db $(1)/usr/share/ouidb/
endef

$(eval $(call BuildPackage,ouidb))
