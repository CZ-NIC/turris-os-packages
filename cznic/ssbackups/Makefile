#
## Copyright (C) 2016-2017 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=ssbackups
PKG_VERSION:=1.3
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/server-side-backups-client.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
PKG_LICENSE:=GPL-3.0

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

define Package/$(PKG_NAME)
	TITLE:=Server side backups
	URL:=https://gitlab.labs.nic.cz/turris/server-side-backups-client
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
	DEPENDS:=+curl +gnupg +python3-base
endef

define Package/$(PKG_NAME)/description
	Server Side Backups is simple REST API providing server-side router backups
  management. This tool is a client for such service.
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,,install --prefix=/usr --root=$(PKG_INSTALL_DIR))
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) 	$(1)/usr/bin
	$(INSTALL_BIN) 	./files/ssbackups $(1)/usr/bin/ssbackups
	$(INSTALL_DIR) $(1)$(PYTHON3_PKG_DIR)/
	$(CP) \
		$(PKG_INSTALL_DIR)$(PYTHON3_PKG_DIR)/* \
		$(1)$(PYTHON3_PKG_DIR)/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
