#
## Copyright (C) 2014-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=2.7

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
    create_notification -s news " • Odstraněn hash-checker.
 • Oprava vícejazyčné podpory user_notify.
 • Firewall sbírá data z více WAN rozhraní.
 • Přidán python-turris-gpio ‒ python modul pro ovládání GPIO.
 • Minidlna aktualizován na 1.1.4.
 • Lighttpd aktualizován a jeho konfigurace zmodularizovaná.
 • Drobné opravy:
   ◦ ucollect
   ◦ updater" " • Removed hte hash-checker.
 • The multi-language support of user_notify is fixed.
 • The firewall collects data from multiple WAN interfaces.
 • Added python-turris-gpio ‒ a python module to control GPIO.
 • Minidlna is updated to 1.1.4.
 • Lighttpd is updated and its configuration is modularized.
 • Minor fixes:
   ◦ ucollect
   ◦ updater"
}
endef


define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
