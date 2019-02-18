#
## Copyright (C) 2016-2018 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=updater-ng
PKG_VERSION:=62.0.8.1
PKG_RELEASE:=2
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/updater.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
HOST_BUILD_DIR:=$(BUILD_DIR_HOST)/$(PKG_NAME)
HOST_BUILD_DEPENDS:=curl/host libevent2/host lua/host
PKG_BUILD_DEPENDS:=busybox

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/$(PKG_NAME)
	TITLE:=The next generation updater
	DEPENDS:=+liblua +libuci-lua +libevent2 +usign +libcurl +ca-certificates
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lib/libupdater.so $(1)/usr/lib/

	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/pkgupdate $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/pkgtransaction $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/updater
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/src/pkgupdate/configs/conf.lua $(1)/etc/updater
	$(INSTALL_DIR) $(1)/etc/updater/conf.d
	$(INSTALL_CONF) ./files/turris.lua $(1)/etc/updater/conf.d/turris.lua
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/src/pkgupdate/configs/example.lua $(1)/etc/updater/conf.d/example.lua

	$(INSTALL_DIR) $(1)/etc/updater/hook_preupdate
	touch $(1)/etc/updater/hook_preupdate/.keep
	$(INSTALL_DIR) $(1)/etc/updater/hook_postupdate
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/pkgupdate/hook_postupdate/update_alternatives.sh $(1)/etc/updater/hook_postupdate/20_update_alternatives.sh
	$(INSTALL_DIR) $(1)/etc/updater/hook_reboot_required
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/pkgupdate/hook_reboot_required/50-create-notification.sh $(1)/etc/updater/hook_reboot_required/50-create-notification.sh

	# Note: this file is not ever used as appropriate one is generated to medkit
	# it is here only for reference and to make sure that it exists.
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/updater.config $(1)/etc/config/updater
endef

define Package/$(PKG_NAME)/conffiles
/etc/updater/conf.d/example.lua
/etc/config/updater
endef


define Package/$(PKG_NAME)-supervisor
	TITLE:=Next generation updater supervisor and its library
	DEPENDS:=+updater-ng +vixie-cron +python3-light +python3-uci +pkglists +l10n_supported
endef

define Py3Package/$(PKG_NAME)-supervisor/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/supervisor/updater-supervisor $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/supervisor/immediate_reboot.init $(1)/etc/init.d/updater-journal-recover
	$(INSTALL_DIR) $(1)/etc/cron.d
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/src/supervisor/cron $(1)/etc/cron.d/updater

	$(INSTALL_DIR) $(1)/etc/updater/hook_postupdate
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/supervisor/hook_postupdate $(1)/etc/updater/hook_postupdate/99_approvals_cleanup
endef


define Package/$(PKG_NAME)-localrepo
	TITLE:=Next generation updater local repository manager
	DEPENDS:=+python3-light
endef

define Package/$(PKG_NAME)-localrepo/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/localrepo/localrepo $(1)/usr/bin/localrepo
	$(INSTALL_DIR) $(1)/etc/updater/conf.d
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/src/localrepo/localrepo.lua $(1)/etc/updater/conf.d/localrepo.lua
endef

# Repository should be consistent when updater is executed successfully but this
# ensures that we will fix any problems that can be caused by older version of
# localrepo
define Package/$(PKG_NAME)-localrepo/postinst
[ -n "$$IPKG_INSTROOT" ] || {
	localrepo check --fix
}
endef


define Package/$(PKG_NAME)-opkg
	TITLE:=OPKG compatibility wrapper for next generation updater
	DEPENDS:=+opkg +$(PKG_NAME)-localrepo
endef

define Package/$(PKG_NAME)-opkg/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/opkg-wrapper/opkg $(1)/usr/bin/opkg-pkgupdate-wrapper.sh
	$(INSTALL_DIR) $(1)/etc/updater/conf.d
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/src/opkg-wrapper/opkg.lua $(1)/etc/updater/conf.d/opkg.lua
	$(INSTALL_DIR) $(1)/etc/updater/opkg-ignore
	touch $(1)/etc/updater/opkg-ignore/.keep
endef


define Build/Compile
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS) NO_DOC=1 LUA_COMPILE:=no UPDATER_VERSION:=$(PKG_VERSION) BUSYBOX_EXEC=$(STAGING_DIR)/bin/busybox-static
	$(call Build/Compile/Py3Mod,src/supervisor,install --prefix="/usr" --root=$(PKG_INSTALL_DIR))
endef

define Host/Compile
	$(MAKE) $(HOST_JOBS) -C $(HOST_BUILD_DIR) $(HOST_MAKE_FLAGS) NO_DOC=1 LUA_COMPILE:=no UPDATER_VERSION:=$(PKG_VERSION)
endef

define Host/Install
	$(INSTALL_DIR) $(STAGING_DIR_HOST)/usr/lib/
	$(INSTALL_BIN) $(HOST_BUILD_DIR)/lib/libupdater.so $(STAGING_DIR_HOST)/usr/lib/

	$(INSTALL_DIR) $(STAGING_DIR_HOST)/usr/bin
	$(INSTALL_BIN) $(HOST_BUILD_DIR)/bin/pkgupdate $(STAGING_DIR_HOST)/usr/bin/
	$(INSTALL_BIN) $(HOST_BUILD_DIR)/bin/pkgtransaction $(STAGING_DIR_HOST)/usr/bin/
endef


$(eval $(call Py3Package,updater-ng-supervisor))
$(eval $(call BuildPackage,updater-ng))
$(eval $(call BuildPackage,updater-ng-supervisor))
$(eval $(call BuildPackage,updater-ng-localrepo))
$(eval $(call BuildPackage,updater-ng-opkg))
$(eval $(call HostBuild))
