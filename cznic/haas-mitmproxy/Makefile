#
# Copyright (C) 2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
PKG_NAME:=haas-mitmproxy
PKG_VERSION:=0.1
PKG_RELEASE:=1
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/labs/mitmproxy.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=1ac8c6f97a8bb7c3a4f2aeb74aba80211d5eb69d
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=CZ.NIC <packaging@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/haas-mitmproxy
  SECTION:=net
  CATEGORY:=Network
  TITLE:=mitmproxy
  URL:=https://haas.nic.cz
  DEPENDS:=+python +python-twisted +python-crypto +python-service-identity
  CONFLICTS:=mitmproxy
endef

define Package/haas-mitmproxy/description
Logging proxy/replay servers for multiple protocols.

Supported protocols:
 * Telnet
 * HTTP
 * SSL
 * SSH
 * SNMP
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix=/usr --root=$(PKG_INSTALL_DIR))
	$(INSTALL_DIR) $(PKG_INSTALL_DIR)/etc/init.d/
	$(INSTALL_DATA) ./files/wrapper.conf $(PKG_INSTALL_DIR)/etc/mitmproxy_wrapper.conf
	$(INSTALL_BIN) ./files/init $(PKG_INSTALL_DIR)/etc/init.d/haas-mitmproxy
endef

define Package/schnapps/conffiles
/etc/mitmproxy_wrapper.conf
endef

define Package/haas-mitmproxy/install
	$(INSTALL_DIR) $(1)
	$(CP) \
		$(PKG_INSTALL_DIR)/* \
		$(1)
endef

define Package/haas-mitmproxy/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	sed -i "s|<INTERFACE>|$$(jsonfilter -s "$$(ubus call network.interface dump)" -e "@.interface[@.interface='wan'].l3_device")|" /etc/mitmproxy_wrapper.conf
fi
endef

define Package/haas-mitmproxy/prerm
	/etc/init.d/mitmproxy_wrapper stop || true
	/etc/init.d/mitmproxy_wrapper disable || true
endef

$(eval $(call BuildPackage,haas-mitmproxy))
