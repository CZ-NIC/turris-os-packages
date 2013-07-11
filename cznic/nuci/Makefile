#
## Copyright (C) 2013 CZ.NIC z.s.p.o. <martin.strbacka@nic.cz>
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=nuci
PKG_VERSION:=6
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=ssh://git@git.nic.cz/router/nuci
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=f02bc8be8df58851beed87d7c3be4d88f8aedb49
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Martin Strbacka <martin.strbacka@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/nuci
	TITLE:=nuci
	DEPENDS:=+libnetconf +liblua +libuci +libuci-lua
endef

define Build/Compile
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS) PLUGIN_PATH=/usr/share/nuci/ NO_DOC=1  MAX_LOG_LEVEL:=LOG_DEBUG LUA_COMPILE:=no
endef


define Package/nuci/install
	$(INSTALL_DIR) $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lib/libxmlwrap.so $(1)/usr/lib/

	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/nuci $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/usr/share/nuci/lua_plugins
	$(CP) $(PKG_BUILD_DIR)/lua_plugins/* $(1)/usr/share/nuci/lua_plugins/

	$(INSTALL_DIR) $(1)/usr/share/nuci/lua_lib
	$(CP) $(PKG_BUILD_DIR)/lua_lib/* $(1)/usr/share/nuci/lua_lib/
endef

$(eval $(call BuildPackage,nuci))
