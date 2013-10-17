#
## Copyright (C) 2013 CZ.NIC z.s.p.o. <martin.strbacka@nic.cz>
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=nuci
PKG_VERSION:=13
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=ssh://git@git.nic.cz/router/nuci
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=78752ba4147bdfe31155b5b33c3409e77a6e70d4
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Martin Strbacka <martin.strbacka@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=nuci
	DEPENDS:=+libnetconf +liblua +libuci +libuci-lua +ip +socat +nethist
endef

define Build/Compile
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS) PLUGIN_PATH=/usr/share/nuci/ NO_DOC=1  MAX_LOG_LEVEL:=LOG_DEBUG LUA_COMPILE:=no
endef


define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lib/libnuci_core.so $(1)/usr/lib/

	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/nuci $(1)/usr/bin/
	$(CP) $(PKG_BUILD_DIR)/tools/nucipty $(1)/usr/bin/nucipty

	$(INSTALL_DIR) $(1)/usr/share/nuci/lua_plugins
	$(CP) $(PKG_BUILD_DIR)/src/lua_plugins/*.yin $(1)/usr/share/nuci/lua_plugins/
	$(CP) $(PKG_BUILD_DIR)/src/lua_plugins/*.lua $(1)/usr/share/nuci/lua_plugins/

	$(INSTALL_DIR) $(1)/usr/share/nuci/lua_lib
	$(CP) $(PKG_BUILD_DIR)/src/lua_lib/* $(1)/usr/share/nuci/lua_lib/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
