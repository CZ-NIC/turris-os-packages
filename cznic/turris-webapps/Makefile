#
# Copyright (C) 2018 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=turris-webapps
PKG_VERSION:=1
PKG_RELEASE:=1
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/turris-webapps
	TITLE:=turris-webapps
	DEPENDS:=+lighttpd +lighttpd-mod-alias +lighttpd-mod-fastcgi
endef

define Package/turris-webapps/description
 Common landding page for various installed web apps.
endef

define Build/Compile
	true
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/lighttpd/conf.d/
	$(INSTALL_DATA) ./files/turris-root.conf $(1)/etc/lighttpd/conf.d/turis-root.conf
	$(INSTALL_DIR) $(1)/usr/share/turris-webapps
	$(INSTALL_BIN) ./files/turris-root-cgi $(1)/usr/share/turris-webapps
	$(INSTALL_DIR) $(1)/www/webapps-icons
	$(INSTALL_DATA) ./files/generic-web.svg $(1)/www/webapps-icons/
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
set -x
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/lighttpd restart
}
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
