#
## Copyright (C) 2014-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=2.5

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
    create_notification -s news " • Možnost nainstalovat program pro domácí automatizaci Domoticz, včetně podpory pro Turris Gatgets
 • Výkonostní vylepšení programu Majordomo
 • Podpora pro vybrané DVB tunery
 • Podpora validace ECDSA DNSSEC podpisů v unbound
 • Oprava přesměrování do SSH honeypotu
 • Ucollect používá TLS 1.2
 • Ucollect pozdrží odeslání dat při ztrátě spojení"
}
endef


define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
