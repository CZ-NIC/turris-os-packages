#
# Copyright (C) 2020-2022 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=turris-webapps-tvheadend
PKG_VERSION:=1.0
PKG_RELEASE:=$(AUTORELEASE)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later

include $(INCLUDE_DIR)/package.mk

define Package/turris-webapps-tvheadend
  SECTION:=web
  CATEGORY:=Web
  SUBMENU:=WebApps
  TITLE:=Tvheadend integration
  DEPENDS:=+tvheadend \
    +turris-webapps \
    +lighttpd-mod-proxy
  URL:=https://gitlab.nic.cz/turris/webapps
endef

define Package/turris-webapps-tvheadend/description
  Webapps integration package for TVHeadend.
  See https://tvheadend.org/
endef

define Build/Compile
endef

define Package/turris-webapps-tvheadend/install
	$(INSTALL_DIR) $(1)/usr/share/turris-webapps
	$(INSTALL_DATA) ./files/30_tvheadend.json $(1)/usr/share/turris-webapps/

	$(INSTALL_DIR) $(1)/www/webapps-icons
	$(INSTALL_DATA) ./files/tvheadend.svg $(1)/www/webapps-icons

	$(INSTALL_DIR) $(1)/etc/lighttpd/conf.d
	$(CP) ./files/tvheadend.lighttpd $(1)/etc/lighttpd/conf.d/80-tvheadend.conf
endef

$(eval $(call BuildPackage,turris-webapps-tvheadend))
