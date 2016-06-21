#
## Copyright (C) 2014-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=3.1

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
# Danger: spaces are not ordinary spaces, but special unicode ones
[ -n "$$IPKG_INSTROOT" ] || {
    create_notification -s news " Toto je opravné vydání:
 • logrotate: Přidání chybějícího cron skriptu
 • ddns-scripts: Synchronizace verzí s LuCI
 • ucollect-fwup: Oprava pádu
 • minidlna: Oprava linkování
 • nginx: Přidány chybějící moduly
 • hostapd: Nová verze
 • unbound: Oprava obnovy kotvy
 • multiwan: Zcela odebrán
 • mwan3: Oprava cest k ip
 • motion: Konfigurační soubor není přepisován novou verzí
 • kernel: Oprava zavádění DVB modulů při startu systému" " This is a bugfix release:
 • logrotate: Addition of missing cron script
 • ddns-scripts: Version sync with LuCI
 • ucollect-fwup: Fix of crash
 • minidlna: Fix of linkage
 • nginx: Missing modules added
 • hostapd: Version bump
 • unbound: Fix of anchor recovery
 • multiwan: Removed completely
 • mwan3: Fix paths to ip
 • motion: Configuration file is not overwritten
 • kernel: Fix loading of the DVB modules on boot"
}
endef


define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
