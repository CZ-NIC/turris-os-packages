#
## Copyright (C) 2013-2014 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=nuci
PKG_VERSION:=93
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/nuci.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=2da897b8e2315c203dbfc2f29e108575b004fb7b
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Martin Strbacka <martin.strbacka@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=nuci
	DEPENDS:=+libnetconf +liblua +libuci +libuci-lua +ip +socat +libatsha204 +coreutils +coreutils-base64 +bzip2 +thermometer +user_notify
endef

define Package/nuci-nethist
	TITLE:=nethist plugin for nuci
	DEPENDS:=+nuci +nethist
endef

define Build/Compile
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS) PLUGIN_PATH=/usr/share/nuci/ NO_DOC=1  MAX_LOG_LEVEL:=LOG_DEBUG LUA_COMPILE:=no
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lib/libnuci_core.so $(1)/usr/lib/

	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/nuci $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/nuci-helper-config-restore $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/nuci-helper-config-backup $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/nuci-helper-checkconn $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/tools/nucipty $(1)/usr/bin/nucipty

	$(INSTALL_DIR) $(1)/usr/share/nuci/lua_plugins
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/lua_plugins/*.yin $(1)/usr/share/nuci/lua_plugins/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/lua_plugins/*.lua $(1)/usr/share/nuci/lua_plugins/
	rm $(1)/usr/share/nuci/lua_plugins/nethist.*

	$(INSTALL_DIR) $(1)/usr/share/nuci/lua_lib
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/lua_lib/* $(1)/usr/share/nuci/lua_lib/
endef

define Package/nuci-nethist/install
	$(INSTALL_DIR) $(1)/usr/share/nuci/lua_plugins
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/lua_plugins/nethist.yin $(1)/usr/share/nuci/lua_plugins/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/lua_plugins/nethist.lua $(1)/usr/share/nuci/lua_plugins/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
$(eval $(call BuildPackage,nuci-nethist))
