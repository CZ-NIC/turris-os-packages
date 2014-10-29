#
## Copyright (C) 2014 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=1.7

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
    create_notification -s news " • Drobné opravy v ucollect & ucollect-flow.
 • Nový plugin ucollect-spoof na testování zasílání packetů s podvrženou zdrojovou adresou.
 • Nový plugin ucollect-refused na sledování odchozích odmítnutých spojení.
 • Možnost v /etc/config/firewall-turris nastavit, která pravidla firewallu se mají aplikovat a která ne.
 • Přidán seznam balíčků 'majordomo'.
 • Opravena chyba ve forisu, ke které mohlo docházet při současném přístupu více uživatelů.
 • Python aktualizován na 2.7.8."
}
endef


define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
