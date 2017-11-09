#
## Copyright (C) 2016-2017 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=ssbackups
PKG_VERSION:=1.0
PKG_RELEASE:=0

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/server-side-backups-client.git
PKG_SOURCE_VERSION:=58afbf5282d0fcb67d7ac134209dd58d28babc71
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=Server side backups
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
	DEPENDS:=+curl +gnupg +python-base
endef

define Package/$(PKG_NAME)/description
	Server Side Backups is simple REST API providing server-side router backups
  management. This tool is a client for such service.
endef

define Build/Compile
  true
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) 	$(1)/usr/bin
	$(INSTALL_BIN) 	$(PKG_BUILD_DIR)/bin/ssbackups.py $(1)/usr/bin/ssbackups
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
