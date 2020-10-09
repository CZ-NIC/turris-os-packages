#
# Copyright (C) 2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=turris-webapps-luci
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later

include $(INCLUDE_DIR)/package.mk

define Package/turris-webapps-luci
  SECTION:=web
  CATEGORY:=Web
  SUBMENU:=WebApps
  TITLE:=LuCI integration
  DEPENDS:=+luci-base \
    +turris-webapps
  PROVIDES:=luci-lighttpd
endef

define Package/turris-webapps-luci/description
  Webapps integration package for LuCI.
endef

define Build/Compile
endef

define Package/turris-webapps-luci/install
	$(INSTALL_DIR) $(1)/etc/lighttpd/conf.d
	$(CP) files/luci.lighttpd $(1)/etc/lighttpd/conf.d/luci.conf
	$(INSTALL_DIR) $(1)/www/webapps-icons
	$(CP) files/luci.svg $(1)/www/webapps-icons/luci.svg
	$(INSTALL_DIR) $(1)/usr/share/turris-webapps
	$(CP) files/luci.webapps $(1)/usr/share/turris-webapps/05_luci.conf
endef

define Package/turris-webapps-luci/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || /etc/init.d/lighttpd restart
endef

$(eval $(call BuildPackage,turris-webapps-luci))
