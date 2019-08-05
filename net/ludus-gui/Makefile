#
# Copyright (C) 2019 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
#
include $(TOPDIR)/rules.mk

PKG_NAME:=ludus-gui
PKG_VERSION:=0.1
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git@gitlab.labs.nic.cz:turris/ludus.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=8e4eeb2c0daefbb43c2a4dddda3beff36e8acd22
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-only
PKG_LICENSE_FILES:=LICENSE

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/ludus-gui
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Ludus web GUI
  URL:=https://gitlab.labs.nic.cz/turris/ludus
  DEPENDS:= \
    +python3-light \
    +python3-flask \
    +python3-flask-login \
    +python3-maxminddb \
    +python3-pbkdf2 \
    +ludus
endef

define Package/ludus-gui/description
  Web GUI for Ludus system with simple dashboard
endef

define Build/Compile
	true
endef

define Build/Install
	true
endef

define Package/ludus-gui/postinst
#!/bin/sh
[ -z "$${IPKG_INSTROOT}" ] && {
	/etc/init.d/lighttpd restart
	[ -f "/etc/init.d/ludus" ] && /etc/init.d/ludus enable && /etc/init.d/ludus start
}
endef

define Package/ludus-gui/install
	$(INSTALL_DIR) $(1)/usr/share/turris-webapps
	$(INSTALL_DATA) ./files/40_ludus.conf $(1)/usr/share/turris-webapps/
	$(INSTALL_DIR) $(1)/www/webapps-icons
	$(INSTALL_DATA) ./files/ludus.jpg $(1)/www/webapps-icons
	$(INSTALL_DIR) $(1)/etc/lighttpd/conf.d
	$(INSTALL_DATA) ./files/ludus_lighttpd.conf $(1)/etc/lighttpd/conf.d/ludus.conf
	$(INSTALL_DIR) $(1)/usr/share/ludus-gui
	$(CP) -r $(PKG_BUILD_DIR)/{db,static,templates} $(1)/usr/share/ludus-gui/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/{ludus_back.py,__init__.py} $(1)/usr/share/ludus-gui/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/{ludus.py,run.sh,ludus.fcgi} $(1)/usr/share/ludus-gui/
endef

$(eval $(call BuildPackage,ludus-gui))
