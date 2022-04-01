#
# Copyright (C) 2019-2022 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-ws
PKG_VERSION:=1.6.2
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/foris-controller/foris-ws.git
PKG_MIRROR_HASH:=9ed6c5ce90b0a11bacb9cd57a26a9fcf4ffa768bb4a58f5f221fb3627ea5e1e2
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=COPYING

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/foris-ws
  SECTION:=web
  CATEGORY:=Web
  SUBMENU:=Foris Controller
  TITLE:=foris-ws
  URL:=https://gitlab.nic.cz/turris/foris-controller/foris-ws
  DEPENDS:= \
    +python3-light \
    +python3-websockets \
    +python3-prctl \
    +rpcd \
    +foris-client \
    +python3-ubus \
    +lighttpd-mod-proxy \
    +turris-auth \
    +fosquitto \
    +python3-cachelib \
    +python3-paho-mqtt
endef

define Package/foris-ws/description
	Websocket server implementation for foris notifications.
endef

define Package/foris-ws/conffiles
/etc/config/foris-ws
endef

define Py3Package/foris-ws/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF) ./files/foris-ws.conf $(1)/etc/config/foris-ws
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/foris-ws.init $(1)/etc/init.d/foris-ws
	$(INSTALL_DIR) $(1)/usr/libexec/rpcd/
	$(INSTALL_BIN) ./files/websocket-listen $(1)/usr/libexec/rpcd/websocket-listen
	$(INSTALL_DIR) $(1)/usr/share/foris-ws/bin/
	$(INSTALL_BIN) ./files/socat.sh $(1)/usr/share/foris-ws/bin/socat.sh
	$(INSTALL_DIR) $(1)/etc/lighttpd/conf.d/
	$(INSTALL_DATA) ./files/lighttpd-foris-ws.conf $(1)/etc/lighttpd/conf.d/70-foris-ws.conf
endef

define Package/foris-ws/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	/etc/init.d/foris-ws enable
	/etc/init.d/foris-ws restart
}
endef

define Package/foris-ws/prerm
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	/etc/init.d/foris-ws stop
	/etc/init.d/foris-ws disable
}
endef

$(eval $(call Py3Package,foris-ws))
$(eval $(call BuildPackage,foris-ws))
$(eval $(call BuildPackage,foris-ws-src))
