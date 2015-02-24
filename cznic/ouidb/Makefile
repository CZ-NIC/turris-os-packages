#
## Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=ouidb
PKG_VERSION:=3
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/ouidb.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=3fa0339fdd3e9a6c825adae8408ab189546d0cce
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Robin Obůrka <robin.oburka@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
endef

# The built is empty. But as there's no makefile in the git repo, we need to
# override the default that runs "make".
define Build/Compile
	true
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/share/ouidb/
	$(INSTALL_DIR) $(1)/usr/bin/

	$(INSTALL_BIN) $(PKG_BUILD_DIR)/ouidb $(1)/usr/bin/

	$(INSTALL_DATA) $(PKG_BUILD_DIR)/oui.db $(1)/usr/share/ouidb/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
