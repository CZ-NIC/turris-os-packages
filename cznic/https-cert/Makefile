#
## Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=https-cert
PKG_VERSION:=1
PKG_MAINTAINER:=Robin Obůrka <robin.oburka@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
endef

define Build/Compile
echo "ahoj"
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/lighttpd/conf.d/
	$(INSTALL_DATA) ./files/ssl-enable.conf $(1)/etc/lighttpd/conf.d/ssl-enable.conf
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
openssl req -new -x509 -keyout /etc/lighttpd-self-signed.pem -out /etc/lighttpd-self-signed.pem -days 1825 -nodes -subj "/C=CZ/ST=Prague/L=Prague/O=Turris"
/etc/init.d/lighttpd restart
create_notification -s news 'Součástí poslední aktualizace byl balíček https-cert, který vám povolil HTTPS spojení a na vašem routeru vygenerovat self-signed certifikát. Od této chvíle se tedy můžete připojit i na adrese https://ip.adresa.vaseho.routeru/ jak do rozhraní Foris, tak do rozhraní LuCI. Je nutné počítat s tím, že vám váš prohlížeč bude hlásit chybu certifikátu. Více informací na: https://www.turris.cz/doc/navody/pristup_z_vnejsi_site'
}
endef

define Package/$(PKG_NAME)/postrm
#!/bin/sh
/etc/init.d/lighttpd restart
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
