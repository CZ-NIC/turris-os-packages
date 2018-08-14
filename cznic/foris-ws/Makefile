#
# Copyright (C) 2018 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-ws
PKG_VERSION:=0.2
PKG_RELEASE:=1
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/foris-ws
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
PKG_LICENSE:=GPL-3.0

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)


define Package/foris-ws
	TITLE:=foris-ws
	URL:=https://gitlab.labs.nic.cz/turris/foris-ws
	DEPENDS:=+python3-light +python3-websocket-server +python3-prctl +rpcd +foris-client-python3 +python3-ubus +lighttpd-mod-proxy
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef

define Package/foris-ws/description
	Websocket server implementation for foris notifications.
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,,install --prefix=/usr --root=$(PKG_INSTALL_DIR))
endef

define Package/foris-ws/conffiles
/etc/config/foris-ws
endef

define Package/foris-ws/install
	$(INSTALL_DIR) $(1)
	$(CP) $(PKG_INSTALL_DIR)/* $(1)/
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF) ./files/foris-ws.conf $(1)/etc/config/foris-ws
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/foris-ws.init $(1)/etc/init.d/foris-ws
	$(INSTALL_DIR) $(1)/usr/libexec/rpcd/
	$(INSTALL_BIN) ./files/websocket-listen $(1)/usr/libexec/rpcd/websocket-listen
	$(INSTALL_DIR) $(1)/usr/share/foris-ws/bin/
	$(INSTALL_BIN) ./files/socat.sh $(1)/usr/share/foris-ws/bin/socat.sh
	$(INSTALL_DIR) $(1)/etc/lighttpd/conf.d/
	$(INSTALL_DATA) ./files/lighttpd-foris-ws.conf $(1)/etc/lighttpd/conf.d/foris-ws.conf
endef

define Package/foris-ws/postinst
#!/bin/sh
set -x
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/foris-ws enable
/etc/init.d/foris-ws restart
}
endef

define Package/foris-ws/prerm
#!/bin/sh
set -x
/etc/init.d/foris-ws stop
/etc/init.d/foris-ws disable
endef

$(eval $(call BuildPackage,foris-ws))
