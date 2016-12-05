#
## Copyright (C) 2014-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=3.3

PKG_MAINTAINER:=Michal Vaner <michal.vaner@nic.cz>

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
endef

define Build/Prepare
endef

define Build/Compile
endef

ifeq ($(CONFIG_TARGET_mvebu_Turris-Omnia),y)

define Package/$(PKG_NAME)/postinst
#!/bin/sh
# Danger: spaces are not ordinary spaces, but special unicode ones
[ -n "$$IPKG_INSTROOT" ] || {
    create_notification -s news " • kernel: Update na poslední dostupnou verzi
 • updater-ng: Podpora priorit, řešení kolizí, provides a dalších
 • ucollect-fake: Minipoty http a telnet-alt
 • mac80211: Update na nové verze WiFi ovladačů z LEDE
 • ath10k: Přechod na Candela Technologies driver
 • kernel: Více ovladačů pro DVB tunnery
 • wondershaper byl nahrazen sqm ve výchozí instalaci
 • knot-resolver: Základní podpora pro místní zónu" " • kernel: Update to the latest version
 • updater-ng: Support priorities, collision solutions, provides header and others
 • ucollect-fake: Minipots for http and telnet-alt
 • mac80211: Update to the latest version of WiFi drivers from LEDE
 • ath10k: Switch to Candela Technologies driver
 • kernel: More DVB tunner drivers
 • wondershaper replaced by sqm in default installation
 • knot-resolver: Basic support for local domain"
}
endef

else

define Package/$(PKG_NAME)/postinst
#!/bin/sh
# Danger: spaces are not ordinary spaces, but special unicode ones
[ -n "$$IPKG_INSTROOT" ] || {
    create_notification -s news " • kernel: Update na poslední dostupnou verzi
 • updater-ng: Podpora priorit, řešení kolizí, provides a dalších
 • ucollect-fake: Minipoty http a telnet-alt
 • mac80211: Update na nové verze WiFi ovladačů z LEDE
 • ath10k: Přechod na Candela Technologies driver
 • kernel: Více ovladačů pro DVB tunnery
 • wondershaper byl nahrazen sqm ve výchozí instalaci
 • knot-resolver: Základní podpora pro místní zónu
 • logrotate: Přidání chybějícího cron skriptu
 • ddns-scripts: Oprava kompatibility s LuCI
 • ucollect-fwup: Oprava pádu aplikace
 • minidlna: Oprava kompatibility s knihovnami
 • nginx: Přidány chybějící moduly
 • hostapd: Nová verze balíčku
 • unbound: Oprava nástroje pro obnovu kotvy
 • multiwan: Zcela odebrán
 • mwan3: Oprava cest k nástroji ip
 • motion: Konfigurační soubor není přepisován novou verzí
 • kernel: Oprava zavádění DVB modulů při startu systému
 • openssh: Zotavení se z prázdných klíčů" " • kernel: Update to the latest version
 • updater-ng: Support priorities, collision solutions, provides header and others
 • ucollect-fake: Minipots for http and telnet-alt
 • mac80211: Update to the latest version of WiFi drivers from LEDE
 • ath10k: Switch to Candela Technologies driver
 • kernel: More DVB tunner drivers
 • wondershaper replaced by sqm in default installation
 • knot-resolver: Basic support for local domain
 • logrotate: Missing cron script has been added
 • ddns-scripts: Compatibility with LuCI has been fixed
 • ucollect-fwup: Applied fixes to prevent random crashes
 • minidlna: Linkage with libraries has been fixed
 • nginx: Missing modules have been added
 • hostapd: Package has been updated
 • unbound: Tool for anchor recovery has been fixed
 • multiwan: Package has been removed completely
 • mwan3: Paths to the ip tool have been fixed
 • motion: Configuration file is not overwritten anymore by a new version of the package
 • kernel: Fixed loading of the DVB modules on boot
 • openssh: Recover from empty ssh keys"
}
endef

endif

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
