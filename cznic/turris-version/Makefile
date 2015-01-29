#
## Copyright (C) 2014 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=2.0

PKG_MAINTAINER:=Michal Vaner <michal.vaner@nic.cz>

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
endef

define Build/Prepare
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
    create_notification -s news " • Update openWRT na Barrier Breaker
 • Opravy v nástroji Majordomo
   ◦ Pořadí zobrazovaných měsíců
   ◦ Pád při vložení prázdné konfigurace
   ◦ Optimalizace cache
 • Vylepšení ucollectu
   ◦ Vypisuje statistiky využití paměti
   ◦ Úklid v kódu
   ◦ Odstraněn memory leak v ucollect-bucjets
   ◦ Oprava počítání času v ucollect-bandwidth
   ◦ Opravy chyb z Coverity
 • Syslog podporuje větší zprávy
 • Povoleno větší množství otevřených spojení
 • Bezpečnostní opravy v
   ◦ unbound
   ◦ OpenSSL
 • Podpora modemu Turris
 • Update Forisu (rychlejší, nové funkce)
 • Nové seznamy balíčků
   ◦ squid
   ◦ cacerts (Kořenové certifikáty autorit)
   ◦ tor"
}
endef


define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
