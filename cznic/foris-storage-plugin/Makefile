#
# Copyright (C) 2016 CZ.NIC z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-storage-plugin
PKG_VERSION:=0.1
PKG_RELEASE:=14
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/foris-storage-plugin.git
PKG_SOURCE_VERSION:=5674c88d7b2b06c748d01b06a39faf3bbb6a9869
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILE:=LICENSE

PKG_BUILD_DEPENDS:=foris/host

include $(INCLUDE_DIR)/package.mk
include ../foris/files/foris-plugin.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=\
		+foris +foris-controller-storage-module
	MAINTAINER:=Michal Hrusecky <michal.hrusecky@nic.cz>
endef

define Package/$(PKG_NAME)/description
 Foris plugin for storage management
endef

define Build/Compile
	echo Nothing
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/$(FORIS_PLUGIN_DIR)/storage

	$(CP) \
		$(PKG_BUILD_DIR)/src/* \
		$(1)/$(FORIS_PLUGIN_DIR)/storage/
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
set -x
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/lighttpd restart
}
endef

define Package/$(PKG_NAME)/postrm
#!/bin/sh
set -x
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/lighttpd restart
}
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
