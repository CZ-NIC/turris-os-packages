#
## Copyright (C) 2014-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=3.0

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
    create_notification -s news " • Update OpenWrt na poslední stabilní verzi 15.05 Chaos Calmer.
 • Zapnutí některých hardening voleb pro větší bezpečnost.
 • Balíček multiwan není nadále podporován, nahradil ho mwan3.
 • Příkaz ip je nově k dispozici s více funkcemi.
 • Přidána podpora IPv6 v nuci-tls - rozhraní pro vzdálený monitoring a správu.
 • Došlo k přečíslování GPIO portů.
 • Updater nyní stahuje seznamy balíčků pro opkg.
 • Nainstalovaná metadata o balíčcích nyní obsahují hash všech nainstalovaných souborů.
 • Unbound - přidána podpora pro obnovu poškozené kořenové kotvy.
 • Ovladač pro IT913x DVB tunery nahrazen ovladačem kmod-usb-af9035.
 • Příkaz sleep umí i neceločíselné hodnoty." " • Update OpenWrt to the latest stable version 15.05 Chaos Calmer.
 • Enabled several hardening options for better security.
 • Package multiwan is deprecated so it was replaced by mwan3.
 • Full version of the ip command is installed by default.
 • Added support for IPv6 in nuci-tls - interface for remote monitoring and control.
 • GPIO ports were renumbered.
 • Updater now downloads lists of packages for opkg.
 • Installed package metadata now contain hash of all installed files.
 • Unbound - added support for fixing broken root nachor.
 • Driver for IT913x DVB tuners replaced by kmod-usb-af9035.
 • Sleep command can take fractions of seconds as an argument."
}
endef


define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
