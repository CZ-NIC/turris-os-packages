#
# Copyright (C) 2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=turris-webapps-nextcloud
PKG_VERSION:=1.0
PKG_RELEASE:=2

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later

include $(INCLUDE_DIR)/package.mk

define Package/turris-webapps-nextcloud
  SECTION:=web
  CATEGORY:=Web
  SUBMENU:=WebApps
  TITLE:=Nextcloud integration
  DEPENDS:=+nextcloud \
    +lighttpd
endef

define Package/turris-webapps-nextcloud/description
  Webapps integration package for nextcloud.
endef

define Build/Compile
endef

define Package/turris-webapps-nextcloud/install
	$(INSTALL_DIR) $(1)/usr/share/turris-webapps
	$(INSTALL_DATA) ./files/30_nextcloud.json $(1)/usr/share/turris-webapps/
	$(INSTALL_DIR) $(1)/www/webapps-icons
	$(INSTALL_DATA) ./files/nextcloud.svg $(1)/www/webapps-icons
endef

$(eval $(call BuildPackage,turris-webapps-nextcloud))
