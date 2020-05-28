#
## Copyright (C) 2016-2020 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=updater-ng
PKG_VERSION:=66.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/updater/updater.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

PKG_BUILD_DEPENDS:=busybox libb64 uthash argp-standalone

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  TITLE:=The next generation updater
  DEPENDS:=\
    +liblua \
    +libuci-lua \
    +libevent2 \
    +libcurl \
    +liburiparser \
    +usign \
    +libarchive \
    +ca-certificates
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lib/libupdater.so $(1)/usr/lib/

	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/pkgupdate $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/pkgtransaction $(1)/usr/bin/
	$(INSTALL_BIN) ./files/update_alternatives.sh $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/updater
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/src/pkgupdate/configs/conf.lua $(1)/etc/updater
	$(INSTALL_DIR) $(1)/etc/updater/conf.d
	$(INSTALL_CONF) ./files/turris.lua $(1)/etc/updater/conf.d/turris.lua
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/src/pkgupdate/configs/example.lua $(1)/etc/updater/conf.d/example.lua

	$(INSTALL_DIR) $(1)/etc/updater/hook_preupdate
	touch $(1)/etc/updater/hook_preupdate/.keep
	$(INSTALL_DIR) $(1)/etc/updater/hook_postupdate
	touch $(1)/etc/updater/hook_postupdate/.keep
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


define Build/Compile
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS) \
		NO_DOC=1 LUA_COMPILE:=no \
		BUSYBOX_EXEC=$(STAGING_DIR)/bin/busybox-static \
		ARGP_STANDALONE=y \
		UPDATER_VERSION:=$(PKG_VERSION)
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
