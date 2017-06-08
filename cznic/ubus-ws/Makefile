#
# Copyright (C) 2017 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ubus-ws
PKG_VERSION:=0.6
PKG_RELEASE:=1
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/ubus-ws
PKG_SOURCE_VERSION:=package-v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
PKG_LICENSE:=GPL-3.0

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)


define Package/ubus-ws
	TITLE:=ubus-ws
	URL:=https://gitlab.labs.nic.cz/turris/ubus-ws
	DEPENDS:=+python +python-websocket-server +python-prctl +socat +rpcd +lighttpd-https-cert
	MAINTAINER:=Stepan Henek <stepan.henek@nic.cz>
endef

define Package/ubus-ws/description
	Websocket server implementation for ubus.
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix=/usr --root=$(PKG_INSTALL_DIR))
endef

define Package/ubus-ws/conffiles
/etc/config/ubus-ws
endef

define Package/ubus-ws/install
	$(INSTALL_DIR) $(1)
	$(CP) $(PKG_INSTALL_DIR)/* $(1)/
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF) ./files/ubus-ws.conf $(1)/etc/config/ubus-ws
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/ubus-ws.init $(1)/etc/init.d/ubus-ws
	$(INSTALL_DIR) $(1)/usr/libexec/rpcd/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/rpcd/websocket-listen $(1)/usr/libexec/rpcd/websocket-listen
	$(INSTALL_DIR) $(1)/usr/share/ubus-ws/bin/
	$(INSTALL_BIN) ./files/socat.sh $(1)/usr/share/ubus-ws/bin/socat.sh
endef

define Package/ubus-ws/postinst
#!/bin/sh
set -x
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/ubus-ws enable
/etc/init.d/ubus-ws restart
}
endef

define Package/foris/prerm
#!/bin/sh
set -x
/etc/init.d/ubus-ws stop
/etc/init.d/ubus-ws disable
endef

$(eval $(call BuildPackage,ubus-ws))
