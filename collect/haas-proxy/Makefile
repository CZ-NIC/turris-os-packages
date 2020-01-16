#
# Copyright (C) 2017-2019 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
PKG_NAME:=haas-proxy
PKG_VERSION:=1.9
PKG_RELEASE:=13

PKG_SOURCE_VERSION:=bbf8629d1d64840407eefc23d2b6c8835365347b
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/haas/proxy/raw/$(PKG_SOURCE_VERSION)/release/
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_HASH:=7cccc79ee930f9e3e5115f7e90983b6a6a42b9f4180d3871fa5af0ab0dbdca6a

PKG_MAINTAINER:=CZ.NIC <packaging@nic.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/haas-proxy
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Honeypot as a Service proxy
  URL:=https://haas.nic.cz
  DEPENDS:=+python3-light +python3-cachetools +python3-requests +python3-twisted +python3-crypto +python3-service-identity +sshpass +@KERNEL_CFS_BANDWIDTH
  CONFLICTS:=mitmproxy
  VARIANT:=python3
endef

define Package/haas-proxy/description
  HaaS proxy application forwards incoming traffic from port 22 (commonly used for
  SSH) to the HaaS server, where Cowrie honeypot simulates a device and records
  executed commands.
endef

define Py3Package/haas-proxy/install
	$(INSTALL_DIR) $(1)/usr/libexec/
	$(INSTALL_BIN) ./files/haas-proxy-start $(1)/usr/libexec/haas-proxy-start
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/haas-proxy.init $(1)/etc/init.d/haas-proxy
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/haas.uci $(1)/etc/config/haas
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/haas-proxy.uci.defaults $(1)/etc/uci-defaults/99-haas-proxy
endef

define Package/haas-proxy/conffiles
/etc/config/haas
endef

$(eval $(call Py3Package,haas-proxy))
$(eval $(call BuildPackage,haas-proxy))
