#
# Copyright (C) 2016 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=resolver-conf
PKG_VERSION:=0.0.2
PKG_RELEASE:=8

PKG_MAINTAINER:=Jan Pavlinec <jan.pavlinec@nic.cz>
PKG_LICENSE:=GPL-3.0-or-later

PKG_INSTALL:=0

include $(INCLUDE_DIR)/package.mk

define Package/resolver-conf
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=IP Addresses and Names
	TITLE:=Resolver configuration
	DEPENDS:=+python3-light +python3-multiprocessing +python3-logging +ca-bundle
endef

define Package/resolver-conf/description
  Configuration for knot-resolver and unbound.
endef

define Package/resolver-conf/conffiles
/etc/config/resolver
endef

Build/Compile:=:
Build/Install:=:

define Package/resolver-conf/install
	$(INSTALL_DIR) $(1)/etc/config
ifneq ($(filter-out n,$(CONFIG_PACKAGE_knot-resolver)),)
	$(INSTALL_CONF) ./files/resolver-omnia-config $(1)/etc/config/resolver
else
	$(INSTALL_CONF) ./files/resolver-turris-config $(1)/etc/config/resolver
endif
	$(INSTALL_DIR) $(1)/etc/resolver
	$(INSTALL_BIN) ./files/resolver-conv $(1)/etc/resolver/resolver-conv.sh
	$(INSTALL_BIN) ./files/dhcp_host_domain_ng.py $(1)/etc/resolver/dhcp_host_domain_ng.py
	$(INSTALL_BIN) ./files/dynamic-domain-conv $(1)/etc/resolver/dynamic-domain-conv.sh
	$(INSTALL_DIR) $(1)/usr/libexec/rpcd
	$(INSTALL_BIN) ./files/resolver_rpcd.py $(1)/usr/libexec/rpcd/resolver_rpcd.py
	$(INSTALL_DIR) $(1)/etc/resolver/dns_servers
	$(INSTALL_DIR) $(1)/usr/share/resolver
	$(INSTALL_BIN) ./files/resolver-func.sh $(1)/usr/share/resolver/functions.sh
	$(INSTALL_CONF) ./files/dns_servers/* $(1)/etc/resolver/dns_servers/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/resolver-init $(1)/etc/init.d/resolver
	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface/
	$(INSTALL_BIN) ./files/resolver-reload $(1)/etc/hotplug.d/iface/40-resolver-reload
	$(INSTALL_DIR) $(1)/etc/hotplug.d/dhcp/
	$(INSTALL_BIN) ./files/dynamic-domains.hotplug $(1)/etc/hotplug.d/dhcp/40-dynamic-domains
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/resolver-defaults $(1)/etc/uci-defaults/resolver-defaults
endef

define Package/resolver-conf/postinst
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
