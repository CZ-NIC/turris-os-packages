#
## Copyright (C) 2014-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=2.6

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
    create_notification -s news " • Podpora více WiFi kanálů v 5GHz pásmu.
 • Přidán Home Assistant s podporou Turris Gatgets.
 • Přidán správce balíčků pip pro Python.
 • Přidán Python 3.
 • Vícejazyčná podpora pro notifikace.
 • Použití wpad místo wpa_supplicant a hostapd.
 • Opravy:
   ◦ Spolehlivější detekce online stavu uCollectu.
   ◦ Oprava buffer overflow v libevent.
   ◦ Oprava kontroly MAC adresy ve Forisu.
   ◦ Instalace chybějícího souboru /etc/config/tvheadend." " • Support for more 5GHz WiFi channels.
 • Added Home Assistant with Turris Gadgets support.
 • Added Python package manager pip.
 • Added Python 3.
 • Multilingual support for notifications.
 • Use of wpad instead of wpa_supplicant and hostapd.
 • Fixes:
   ◦ More accurate detection of uCollect online status.
   ◦ Buffer overflow bugfix in libevent.
   ◦ Fix of MAC address validation in Foris.
   ◦ Installation of missing /etc/config/tvheadend."
}
endef


define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
