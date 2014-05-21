#
## Copyright (C) 2014 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=1.2

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
    create_notification -s news " • Opraveny balíčky rrdtool a usbip. Aktualizován balíček git na verzi 1.9.3.
 • Opraveny chyby v zasílání oznámení o aktualizacích. Maximální prodleva pro plánované restarty byla omezena na 10 dní.
 • Aktualizován český překlad rozhraní Luci.
 • Přidán watchdog kontrolující správnou funkci unbound démona.
 • Aktualizovány balíčky Foris a Ucollect."
}
endef


define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
