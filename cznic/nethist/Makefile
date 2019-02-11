#
## Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=nethist
PKG_VERSION:=14
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/misc.git
PKG_SOURCE_VERSION:=358ab7a44b8af1470e6a6b42a7a75edff88057d0
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+thermometer
endef

define Build/Compile
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR)/nethist $(MAKE_FLAGS)
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/nethist/nethist $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/nethist/nethist_stats.lua $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/nethist.init $(1)/etc/init.d/nethist

	$(INSTALL_DIR) $(1)/etc/cron.d
	$(INSTALL_DATA) ./files/nethist.cron $(1)/etc/cron.d/nethist
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/nethist enable
/etc/init.d/nethist restart
}
endef

define Package/$(PKG_NAME)/prerm
#!/bin/sh
/etc/init.d/nethist disable
/etc/init.d/nethist stop
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
