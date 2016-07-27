#
## Copyright (C) 2013-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=nuci
PKG_VERSION:=126
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/nuci.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=e073bb58e3dcbacd34bc12f2f6c6aa1b7e66a417
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Martin Strbacka <martin.strbacka@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=nuci
	DEPENDS:=+libnetconf +liblua +libuci +libuci-lua +ip +socat +libatsha204 +coreutils +coreutils-base64 +bzip2 +thermometer +user_notify +ntpdate
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
	rm $(patsubst %,$(1)/usr/share/nuci/lua_plugins/%.*,nethist nuci-tls smrt)

	$(INSTALL_DIR) $(1)/usr/share/nuci/lua_lib
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/lua_lib/* $(1)/usr/share/nuci/lua_lib/
endef

define plugin

define Package/nuci-$(1)
	TITLE:=$(2)
	DEPENDS:=+nuci $(3)
endef

define Package/nuci-$(1)/install
	$$(INSTALL_DIR) $$(1)/usr/share/nuci/lua_plugins
	$$(INSTALL_DATA) $$(PKG_BUILD_DIR)/src/lua_plugins/$(1).yin $$(1)/usr/share/nuci/lua_plugins/
	$$(INSTALL_DATA) $$(PKG_BUILD_DIR)/src/lua_plugins/$(1).lua $$(1)/usr/share/nuci/lua_plugins/
endef

endef

$(eval $(call plugin,nethist,Nethist plugin for nuci,+nethist))
$(eval $(call plugin,smrt,Nuci plugin for the smrt modem,))

define Package/nuci-tls
TITLE:=TLS access to nuci
DEPENDS:=+nuci +socat +openssl-util
endef

define Package/nuci-tls/install
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/tls/init $(1)/etc/init.d/nuci-tls
	$(INSTALL_DIR) $(1)/usr/share/nuci/tls/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/tls/start $(1)/usr/share/nuci/tls/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/tls/new_ca $(1)/usr/share/nuci/tls/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/tls/new_client $(1)/usr/share/nuci/tls/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/tls/openssl.cnf $(1)/usr/share/nuci/tls
	$(INSTALL_DATA) ./files/dhparam.pem $(1)/usr/share/nuci/tls/provided-dhparam.pem
	$(INSTALL_DIR) $(1)/usr/share/nuci/tls/ca
	$(INSTALL_DIR) $(1)/usr/share/nuci/tls/clients
	$(INSTALL_DIR) $(1)/usr/share/nuci/lua_plugins
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/lua_plugins/nuci-tls.yin $(1)/usr/share/nuci/lua_plugins/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/lua_plugins/nuci-tls.lua $(1)/usr/share/nuci/lua_plugins/
endef

define Package/nuci-tls/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/nuci-tls enable || true
/etc/init.d/nuci-tls restart
}
endef

define Package/nuci-tls/prerm
#!/bin/sh
/etc/init.d/nuci-tls disable || true
/etc/init.d/nuci-tls stop
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
$(eval $(call BuildPackage,nuci-smrt))
$(eval $(call BuildPackage,nuci-nethist))
$(eval $(call BuildPackage,nuci-tls))
