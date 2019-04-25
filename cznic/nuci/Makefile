#
## Copyright (C) 2013-2017 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=nuci
PKG_VERSION:=162
PKG_RELEASE:=1
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/nuci.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=nuci
	DEPENDS:=+libnetconf +liblua +libuci +libuci-lua +ip +socat +libatsha204 +coreutils +coreutils-base64 +bzip2 +thermometer +user-notify +ntpdate +vixie-cron +turris-maintain
endef

define Build/Compile
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS) PLUGIN_PATH=/usr/share/nuci/ NO_DOC=1  MAX_LOG_LEVEL:=LOG_DEBUG LUA_COMPILE:=no
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lib/libnuci_core.so $(1)/usr/lib/

	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/nuci $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/nuci-helper-checkconn $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/nuci-helper-autocollect $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/tools/nucipty $(1)/usr/bin/nucipty

	$(INSTALL_DIR) $(1)/usr/share/nuci/lua_plugins
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/lua_plugins/*.yin $(1)/usr/share/nuci/lua_plugins/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/lua_plugins/*.lua $(1)/usr/share/nuci/lua_plugins/
	rm $(patsubst %,$(1)/usr/share/nuci/lua_plugins/%.*,nethist nuci-tls smrt diagnostics ca-gen openvpn-client)

	$(INSTALL_DIR) $(1)/usr/share/nuci/lua_lib
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/lua_lib/* $(1)/usr/share/nuci/lua_lib/

	$(INSTALL_DIR) $(1)/etc/cron.d
	$(INSTALL_DATA) ./files/autocollect.cron $(1)/etc/cron.d/autocollect
endef

define Package/$(PKG_NAME)/postinst
[ -n "$$IPKG_INSTROOT" ] || {
/usr/bin/nuci-helper-autocollect
}
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
$(eval $(call plugin,diagnostics,Nuci plugin for the diagnostics module,+turris-diagnostics))

define Package/nuci-tls
TITLE:=TLS access to nuci
DEPENDS:=+nuci +socat +openssl-util +dhparam
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

define Package/nuci-ca-gen
TITLE:=Nuci plugin for generating CAs, certificates and dhparams
DEPENDS:=+nuci +openssl-util
endef

define Package/nuci-ca-gen/install
	$(INSTALL_DIR) $(1)/usr/share/nuci/ca
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/ca/gen $(1)/usr/share/nuci/ca/
	$(INSTALL_DIR) $(1)/usr/share/nuci/lua_plugins
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/ca/openssl.cnf $(1)/usr/share/nuci/ca/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/lua_plugins/ca-gen.yin $(1)/usr/share/nuci/lua_plugins/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/lua_plugins/ca-gen.lua $(1)/usr/share/nuci/lua_plugins/
	$(INSTALL_DIR) $(1)/etc/cron.d/
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/src/ca/nuci-ca.cron $(1)/etc/cron.d/
endef

define Package/nuci-openvpn-client
TITLE:=Nuci plugin for obtaining openvpn client config
DEPENDS:=+nuci +openvpn-openssl
endef

define Package/nuci-openvpn-client/install
	$(INSTALL_DIR) $(1)/usr/share/nuci/lua_plugins
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/lua_plugins/openvpn-client.yin $(1)/usr/share/nuci/lua_plugins/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/lua_plugins/openvpn-client.lua $(1)/usr/share/nuci/lua_plugins/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
$(eval $(call BuildPackage,nuci-smrt))
$(eval $(call BuildPackage,nuci-nethist))
$(eval $(call BuildPackage,nuci-diagnostics))
$(eval $(call BuildPackage,nuci-tls))
$(eval $(call BuildPackage,nuci-ca-gen))
$(eval $(call BuildPackage,nuci-openvpn-client))
