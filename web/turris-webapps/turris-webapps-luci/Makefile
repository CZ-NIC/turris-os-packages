#
# Copyright (C) 2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=turris-webapps-luci
PKG_VERSION:=1.1
PKG_RELEASE:=$(AUTORELEASE)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later

include $(INCLUDE_DIR)/package.mk

define Package/turris-webapps-luci
  SECTION:=web
  CATEGORY:=Web
  SUBMENU:=WebApps
  TITLE:=LuCI integration
  DEPENDS:=+luci-base \
    +turris-webapps +lighttpd-mod-setenv
  PROVIDES:=luci-lighttpd
  URL:=https://gitlab.nic.cz/turris/webapps
endef

define Package/turris-webapps-luci/description
  WebApps integration package for LuCI.
endef

define Build/Compile
endef

define Package/turris-webapps-luci/install
	$(INSTALL_DIR) $(1)/etc/lighttpd/conf.d
	$(CP) ./files/luci.lighttpd $(1)/etc/lighttpd/conf.d/luci.conf
	$(INSTALL_DIR) $(1)/www/webapps-icons
	$(CP) ./files/luci.svg $(1)/www/webapps-icons/luci.svg
	$(INSTALL_DIR) $(1)/usr/share/turris-webapps
	$(INSTALL_DATA) ./files/05_luci.json $(1)/usr/share/turris-webapps/
endef

define Package/turris-webapps-luci/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || /etc/init.d/lighttpd restart
endef

$(eval $(call BuildPackage,turris-webapps-luci))
