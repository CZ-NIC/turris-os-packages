#
# Copyright (C) 2015 CZ.NIC z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-tls-plugin
PKG_VERSION:=4
PKG_RELEASE:=1
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/foris-tls-plugin.git
PKG_SOURCE_VERSION:=package-v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILE:=LICENSE

PKG_BUILD_DEPENDS:=foris/host

include $(INCLUDE_DIR)/package.mk
$(call include_mk, foris-plugin.mk)


define Package/foris-tls-plugin
	TITLE:=foris-tls-plugin
	DEPENDS:=\
		+foris +nuci-tls
	MAINTAINER:=Jan Cermak <jan.cermak@nic.cz>
endef

define Package/foris-tls-plugin/description
 Foris plugin providing frontend for NUCI TLS plugin.
endef

define Build/Compile
	$(call Build/Compile/ForisPlugin)
endef

define Package/foris-tls-plugin/postinst
#!/bin/sh
set -x
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/lighttpd restart
}
endef

$(eval $(call ForisPlugin,foris-tls-plugin,tls))
$(eval $(call BuildPackage,foris-tls-plugin))
