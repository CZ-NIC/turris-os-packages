#
# Copyright (C) 2016 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=resolver-conf
PKG_VERSION:=0.0.1
PKG_RELEASE:=18

PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_MAINTAINER:=Jan Pavlinec <jan.pavlinec@nic.cz>
PKG_LICENSE:=GPL-3.0

PKG_INSTALL:=0

include $(INCLUDE_DIR)/package.mk

define Package/resolver-conf
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=IP Addresses and Names
	TITLE:=Resolver configuration
	DEPENDS:=+python +ca-bundle
endef

define Package/$(PKG_NAME)/description
  Configuration for knot-resolver and unbound.
endef

define Package/$(PKG_NAME)/conffiles
/etc/config/resolver
endef

define Build/Compile
endef

define Build/Install
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DIR) $(1)/etc/resolver
	$(INSTALL_BIN) ./files/resolver-conv $(1)/etc/resolver/resolver-conv.sh
	$(INSTALL_BIN) ./files/dhcp_host_domain_ng.py $(1)/etc/resolver/dhcp_host_domain_ng.py
	$(INSTALL_BIN) ./files/dynamic-domain-conv $(1)/etc/resolver/dynamic-domain-conv.sh
	$(INSTALL_DIR) $(1)/usr/libexec/rpcd
	$(INSTALL_BIN) ./files/resolver_rpcd.py $(1)/usr/libexec/rpcd/resolver_rpcd.py
	$(INSTALL_DIR) $(1)/etc/resolver/dns_servers
ifeq ($(CONFIG_TARGET_mvebu_Turris-Omnia),y)
	$(INSTALL_CONF) ./files/resolver-omnia-config $(1)/etc/config/resolver
	$(INSTALL_CONF) ./files/dns_servers_omnia/* $(1)/etc/resolver/dns_servers/
else
	$(INSTALL_CONF) ./files/resolver-turris-config $(1)/etc/config/resolver
	$(INSTALL_CONF) ./files/dns_servers_turris/* $(1)/etc/resolver/dns_servers/
endif
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/resolver-init $(1)/etc/init.d/resolver
	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface/
	$(INSTALL_BIN) ./files/resolver-reload $(1)/etc/hotplug.d/iface/40-resolver-reload
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/resolver-defaults $(1)/etc/uci-defaults/resolver-defaults
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
# check if we are on real system
if [ -z "$$IPKG_INSTROOT" ]; then
	/etc/uci-defaults/resolver-defaults && rm /etc/uci-defaults/resolver-defaults
	if [ ! -e "/etc/resolver/converted" ]; then
		/etc/resolver/resolver-conv.sh
		touch /etc/resolver/converted
	fi
	/etc/resolver/dynamic-domain-conv.sh
fi
endef

$(eval $(call BuildPackage,resolver-conf))
