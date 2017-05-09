#
## Copyright (C) 2016-2017 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=opkg-trans
PKG_VERSION:=58.4
PKG_RELEASE:=1
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/updater.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Michal Vaner <michal.vaner@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
HOST_BUILD_DIR:=$(BUILD_DIR_HOST)/$(PKG_NAME)
HOST_BUILD_DEPENDS:=curl/host libevent2/host lua/host

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk

define Package/opkg-trans
	TITLE:=opkg-trans
	DEPENDS:=+liblua +libevent2 +usign +libcurl
endef

define Build/Compile
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS) NO_DOC=1 LUA_COMPILE:=no UPDATER_VERSION:=$(PKG_VERSION)
endef

define Package/opkg-trans/install
	$(INSTALL_DIR) $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lib/libupdater.so $(1)/usr/lib/

	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/opkg-trans $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/pkgupdate $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/pkgupdate/opkg $(1)/usr/bin/opkg-pkgupdate-wrapper.sh

	$(INSTALL_DIR) $(1)/etc/updater
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/src/pkgupdate/configs/* $(1)/etc/updater

	$(INSTALL_DIR) $(1)/etc/updater/hook_preupdate
	$(INSTALL_DIR) $(1)/etc/updater/hook_postupdate
	$(INSTALL_DIR) $(1)/etc/updater/hook_reboot_required
	touch $(1)/etc/updater/hook_preupdate/.keep
	touch $(1)/etc/updater/hook_postupdate/.keep
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/pkgupdate/hook_reboot_required/50-create-notification.sh $(1)/etc/updater/hook_reboot_required/50-create-notification.sh
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
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/pkgupdate/updater-unstuck.sh $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/pkgupdate/updater-wipe.sh $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/ssl
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/legacy/updater.pem $(1)/etc/ssl/updater.pem

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/updater.config $(1)/etc/config/updater
ifneq ($(PKG_BRANCH),)
	echo >> $(1)/etc/config/updater
	echo "config override 'override'" >> $(1)/etc/config/updater
	echo "	option branch '$(PKG_BRANCH)'" >> $(1)/etc/config/updater
endif
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/pkgupdate/init $(1)/etc/init.d/updater

	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/updater.defaults $(1)/etc/uci-defaults/updater
endef

define Package/updater-ng/conffiles
/etc/config/updater
endef

define Package/updater-ng/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/updater enable || true
# Run the uci-defaults now if we are installed at runtime and not flashed
/etc/uci-defaults/updater && rm /etc/uci-defaults/updater
}
endef

define Package/updater-migrate
	TITLE:=Automatic migration to the updater-ng
	DEPENDS:=+opkg-trans +vixie-cron
endef

define Package/updater-migrate/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/migrator/updater-migrate.sh $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/pkgmigrate $(1)/usr/bin
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/migrator/init $(1)/etc/init.d/updater-migrate
endef

define Package/updater-migrate/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/updater-migrate enable || true
# Start migration
/etc/init.d/updater-migrate start
}
endef

define Package/updater-migrate/prerm
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/updater-migrate disable || true
}
endef

define Host/Compile
	$(MAKE) $(HOST_JOBS) -C $(HOST_BUILD_DIR) $(HOST_MAKE_FLAGS) Q= NO_DOC=1 LUA_COMPILE:=no UPDATER_VERSION:=$(PKG_VERSION)
endef

define Host/Install
	$(INSTALL_DIR) $(STAGING_DIR_HOST)/usr/lib/
	$(INSTALL_BIN) $(HOST_BUILD_DIR)/lib/libupdater.so $(STAGING_DIR_HOST)/usr/lib/

	$(INSTALL_DIR) $(STAGING_DIR_HOST)/usr/bin
	$(INSTALL_BIN) $(HOST_BUILD_DIR)/bin/opkg-trans $(STAGING_DIR_HOST)/usr/bin/
	$(INSTALL_BIN) $(HOST_BUILD_DIR)/bin/pkgupdate $(STAGING_DIR_HOST)/usr/bin/
endef

$(eval $(call BuildPackage,opkg-trans))
$(eval $(call BuildPackage,updater-ng))
$(eval $(call BuildPackage,updater-migrate))
$(eval $(call HostBuild))
