#
## Copyright (C) 2014 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=1.3

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
    create_notification -s news " • Nová funkce firewallu pro stahování IPv6 pravidel ze serveru.
 • Firewall používá IPset pro nastavování pravidel, což přispívá k vyššímu výkonu filtrování.
 • Oprava chyby firewallu, která způsobovala neaplikování pravidel z UCI.
 • Oprava pluginu ucollect-bandwidth, který způsoboval vytížení CPU.
 • Automatické ukončení Ucollectu po mnoha nevydařených pokusech o připojení.
 • Oprava balíčku https-cert, která řeší problém s konfiguračním souborem lighttpd."
}
endef


define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
