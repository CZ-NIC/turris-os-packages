#
## Copyright (C) 2014-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=3.2

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
    create_notification -s news " • logrotate: Přidání chybějícího cron skriptu
 • ddns-scripts: Oprava kompatibility s LuCI
 • ucollect-fwup: Oprava pádu aplikace
 • minidlna: Oprava kompatibility s knihovnami
 • nginx: Přidány chybějící moduly
 • hostapd: Nová verze balíčku
 • unbound: Oprava nástroje pro obnovu kotvy
 • multiwan: Zcela odebrán
 • mwan3: Oprava cest k nástroji ip
 • motion: Konfigurační soubor není přepisován novou verzí
 • kernel: Oprava zavádění DVB modulů při startu systému" " • logrotate: Missing cron script has been added
 • ddns-scripts: Compatibility with LuCI has been fixed
 • ucollect-fwup: Applied fixes to prevent random crashes
 • minidlna: Linkage with libraries has been fixed
 • nginx: Missing modules have been added
 • hostapd: Package has been updated
 • unbound: Tool for anchor recovery has been fixed
 • multiwan: Package has been removed completely
 • mwan3: Paths to the ip tool have been fixed
 • motion: Configuration file is not overwritten anymore by a new version of the package
 • kernel: Fixed loading of the DVB modules on boot"
}
endef


define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
