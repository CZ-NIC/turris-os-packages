#
## Copyright (C) 2016 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=opkg-trans
PKG_VERSION:=6
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/updater.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=9149d1b223749c0c819de3143883f3f988f766a6
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Michal Vaner <michal.vaner@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/opkg-trans
	TITLE:=opkg-trans
	DEPENDS:=+liblua +libevent2 +usign
endef

define Build/Compile
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS) NO_DOC=1 LUA_COMPILE:=no
endef

define Package/opkg-trans/install
	$(INSTALL_DIR) $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lib/libupdater.so $(1)/usr/lib/

	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/opkg-trans $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/pkgupdate $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/updater
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/src/pkgupdate/configs/* $(1)/etc/updater
endef

define Package/opkg-trans/conffiles
/etc/updater/auto.lua
/etc/updater/user.lua
endef

define Package/updater-ng
	TITLE:=The next generation updater
	DEPENDS:=+opkg-trans +vixie-cron
endef

define Package/updater-ng/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/pkgupdate/updater.sh $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/ssl
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/legacy/updater.pem $(1)/etc/ssl/updater.pem

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/updater.config $(1)/etc/config/updater

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/pkgupdate/init $(1)/etc/init.d/updater

	$(INSTALL_DIR) $(1)/etc/cron.d
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/pkgupdate/cron $(1)/etc/cron.d/updater
endef

define Package/updater-ng/conffiles
/etc/config/updater
endef

define Package/updater-ng/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/updater enable || true
}
endef

$(eval $(call BuildPackage,opkg-trans))
$(eval $(call BuildPackage,updater-ng))
