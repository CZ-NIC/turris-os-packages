#
# Copyright (C) 2018-2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=turris-webapps
PKG_VERSION:=3.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/webapps
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later

include $(INCLUDE_DIR)/package.mk

define Package/turris-webapps
	TITLE:=Turris WebApps
	DEPENDS:=+lighttpd +lighttpd-mod-alias +lighttpd-mod-cgi
endef

define Package/turris-webapps/description
 Common landding page for various installed web apps.
endef

Build/Compile:=:

define Package/turris-webapps/install
	$(INSTALL_DIR) $(1)/etc/lighttpd/conf.d/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/turris-root.conf $(1)/etc/lighttpd/conf.d/turris-root.conf

	$(INSTALL_DIR) $(1)/usr/share/turris-webapps
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/turris-webapps-json-cgi $(1)/usr/share/turris-webapps
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/l10n.json $(1)/usr/share/turris-webapps

	$(INSTALL_DIR) $(1)/www/turris-webapps
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/favicon.ico $(1)/www/turris-webapps
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/index.html $(1)/www/turris-webapps

	$(INSTALL_DIR) $(1)/www/turris-webapps/css
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/css/*.css $(1)/www/turris-webapps/css

	$(INSTALL_DIR) $(1)/www/turris-webapps/js
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/js/*.js $(1)/www/turris-webapps/js
	$(INSTALL_DIR) $(1)/www/webapps-icons
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/icons/turris.svg $(1)/www/webapps-icons
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/icons/turris-light.svg $(1)/www/webapps-icons
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/icons/turris-dark.svg $(1)/www/webapps-icons

endef

define Package/turris-webapps/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	/etc/init.d/lighttpd restart
}
endef

$(eval $(call BuildPackage,turris-webapps))
