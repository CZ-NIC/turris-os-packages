#
# Copyright (C) 2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=turris-webapps-netdata
PKG_VERSION:=1.0
PKG_RELEASE:=3

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later

include $(INCLUDE_DIR)/package.mk

define Package/turris-webapps-netdata
  SECTION:=web
  CATEGORY:=Web
  SUBMENU:=WebApps
  TITLE:=Netdata integration
  DEPENDS:=+netdata \
    +lighttpd-mod-authn_pam +lighttpd-mod-auth +lighttpd-mod-authn_file \
    +lighttpd-mod-proxy
endef

define Package/turris-webapps-netdata/description
  Webapps integration package for Netdata - see https://www.netdata.cloud/
endef

define Build/Compile
endef

define Package/turris-webapps-netdata/install
	$(INSTALL_DIR) $(1)/etc/lighttpd/conf.d
	$(CP) files/netdata.lighttpd $(1)/etc/lighttpd/conf.d/netdata.conf
	$(INSTALL_DIR) $(1)/www/webapps-icons
	$(CP) files/netdata-logomark.svg $(1)/www/webapps-icons/netdata.svg
	$(INSTALL_DIR) $(1)/usr/share/turris-webapps
	$(CP) files/netdata.webapps $(1)/usr/share/turris-webapps/30_netdata.conf
endef

define Package/turris-webapps-netdata/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || /etc/init.d/lighttpd restart
endef

$(eval $(call BuildPackage,turris-webapps-netdata))

