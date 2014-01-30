#
## Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=rainbow
PKG_VERSION:=12
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/rainbow.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=6a07ea225aef75376c551a741d9818680c7f7c0d
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Michal Vaner <michal.vaner@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
endef

define Build/Compile
	sed -i -e '/^CC=/d' Makefile
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS)
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/rainbow $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/rainbow.init $(1)/etc/init.d/rainbow
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_DATA) ./files/rainbow.config $(1)/etc/config/rainbow
	$(INSTALL_DIR) $(1)/etc/cron.d
	$(INSTALL_DATA) ./files/rainbow.cron $(1)/etc/cron.d/rainbow
	$(INSTALL_BIN) ./files/rainbow_button_sync.sh $(1)/usr/bin/rainbow_button_sync.sh
	$(INSTALL_DATA) ./files/rainbow.magic $(1)/etc/rainbow.magic
endef

define Package/$(PKG_NAME)/conffiles
/etc/config/rainbow
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/rainbow enable
/etc/init.d/rainbow restart
}
endef

define Package/$(PKG_NAME)/prerm
#!/bin/sh
/etc/init.d/rainbow stop
/etc/init.d/rainbow disable
rainbow all auto white
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
