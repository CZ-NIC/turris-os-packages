#
## Copyright (C) 2014-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=2.3

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
    create_notification -s news " • Ucollect: Zavedení minipotu pro telnet. Sleduje útočníky na portu 23.
   Ve výchozím nastavení ukládá jen IP adresy. V rozhraní Foris
   lze zapnout i ukládání hesel nebo celou funkci vypnout.
 • Foris přidává diagnostiku odesílání dat na servery Turris.
 • Updater kontroluje integritu nainstalovaných souborů. Při první
   kontrole přeinstaluje větší množství balíčků.
 • Squid: Nová verze, opravuje chybu CVE-2015-3455.
 • Dropné opravy:
   ◦ Foris
   ◦ cznic-cacert-bundle
   ◦ ucollect
   ◦ updater"
}
endef


define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
