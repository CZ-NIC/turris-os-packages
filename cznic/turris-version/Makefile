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
    create_notification -s news " • Update OpenWRT na stabilní verzi Barrier Breaker
 • Opravy v nástroji Majordomo
   ◦ Pořadí zobrazovaných měsíců
   ◦ Pád při vložení prázdné konfigurace
   ◦ Optimalizace cache
 • Vylepšení ucollectu
   ◦ Vypisuje statistiky využití paměti
   ◦ Úklid v kódu
   ◦ Odstraněn memory leak v ucollect-buckets
   ◦ Oprava počítání času v ucollect-bandwidth
   ◦ Opravy chyb hlášených statickým analyzátorem Coverity
 • Zvýšen limit délky zpráv v syslogu
 • Povoleno větší množství otevřených spojení
 • Bezpečnostní opravy v
   ◦ unbound
   ◦ OpenSSL
 • Podpora modemu Turris
 • Inovované rozhraní Foris
   ◦ Nový vzhled, připravený pro mobilní zařízení
   ◦ Přidaná sekce pro instalaci seznamů balíčků
   ◦ Zrychlení odezvy rozhraní
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
