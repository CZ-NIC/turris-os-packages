#
# Copyright (C) 2018-2019 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=mozilla-iot-gateway-webapp
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later

include $(INCLUDE_DIR)/package.mk

define Package/mozilla-iot-gateway-webapp
  SUBMENU:=Node.js
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Things Gateway by Mozilla (Webapps integration)
  URL:=https://iot.mozilla.org/gateway/
  DEPENDS:=+turris-webapps +node-mozilla-iot-gateway
endef

define Build/Compile
	true
endef

define Package/mozilla-iot-gateway-webapp/description
  Things Gateway by Mozilla integration into Turris OS
endef

define Package/mozilla-iot-gateway-webapp/install
	$(INSTALL_DIR) $(1)/usr/share/turris-webapps
	$(INSTALL_DATA) ./files/30_mozilla-iot.conf $(1)/usr/share/turris-webapps/
	$(INSTALL_DIR) $(1)/www/webapps-icons
	$(INSTALL_DATA) ./files/mozilla-iot.png $(1)/www/webapps-icons
endef

$(eval $(call BuildPackage,mozilla-iot-gateway-webapp))
