#
## Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=https-cert
PKG_VERSION:=3
PKG_MAINTAINER:=Robin Obůrka <robin.oburka@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
endef

define Build/Compile
	true
endef

define Package/https-cert/conffiles
/etc/lighttpd/conf.d/ssl-enable.conf
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/lighttpd/conf.d/
	$(INSTALL_CONF) ./files/ssl-enable.conf $(1)/etc/lighttpd/conf.d/ssl-enable.conf
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
[ -f /etc/lighttpd-self-signed.pem ] || openssl req -new -x509 -keyout /etc/lighttpd-self-signed.pem -out /etc/lighttpd-self-signed.pem -days 1825 -nodes -subj "/C=CZ/ST=Prague/L=Prague/O=Turris"
/etc/init.d/lighttpd restart
}
endef

define Package/$(PKG_NAME)/postrm
#!/bin/sh
/etc/init.d/lighttpd restart
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
