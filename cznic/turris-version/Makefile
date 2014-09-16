#
## Copyright (C) 2014 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=1.6

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
    create_notification -s news " • Opravy pádů updateru a další drobné úpravy.
 • Ucollect - optimalizován systém aktualizace pravidel pluginu flows ze serveru.
 • U flows se zaznamenává, kdo započal komunikaci.
 • Ve firewallu se zaznamenávané a blokované adresy spravují již pouze pomocí ipsets.
 • Foris pro zrychlení odezvy udržuje persistentní připojení k backendu.
 • Notifier zasílá emaily kompletně s diakritikou."
}
endef


define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
