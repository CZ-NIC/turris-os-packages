#
# Copyright (C) 2018 CZ.NIC
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=mozilla-iot-gateway-webapp
PKG_VERSION:=1.0
PKG_RELEASE:=0

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_LICENSE:=GPL-3.0

include $(INCLUDE_DIR)/package.mk

define Package/mozilla-iot-gateway-webapp
  SUBMENU:=Node.js
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Things Gateway by Mozilla (Webapps integration)
  URL:=https://iot.mozilla.org/gateway/
  DEPENDS:=+turris-webapps
  MAINTAINER:=CZ.NIC <packaging@turris.cz>
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
