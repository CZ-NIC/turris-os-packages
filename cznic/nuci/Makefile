#
## Copyright (C) 2013 CZ.NIC z.s.p.o. <martin.strbacka@nic.cz>
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=nuci
PKG_VERSION:=3
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=ssh://git@git.nic.cz/router/nuci
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=5c4b5df59847187fd6eb7d4f5a64a9ba3f4ec94c
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
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS) PLUGIN_PATH=/usr/share/nuci/ NO_DOC=1  MAX_LOG_LEVEL:=LOG_DEBUG
endef


define Package/nuci/install
	$(INSTALL_DIR) $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lib/liblxml2.so $(1)/usr/lib/

	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/nuci $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/usr/share/nuci/lua_plugins
	$(CP) $(PKG_BUILD_DIR)/src/lua_plugins/* $(1)/usr/share/nuci/lua_plugins/

	$(INSTALL_DIR) $(1)/usr/share/nuci/lua_lib
	$(CP) $(PKG_BUILD_DIR)/src/lua_lib/* $(1)/usr/share/nuci/lua_lib/
endef

$(eval $(call BuildPackage,nuci))
