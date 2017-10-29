#
# Copyright (C) 2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
PKG_NAME:=haas-proxy
PKG_VERSION:=1.2
PKG_RELEASE:=2
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/haas/proxy.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=2429e510a51f66fcd6328ce857719fbc7c77c919
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=CZ.NIC <packaging@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/haas-proxy
  SECTION:=net
  CATEGORY:=Network
  TITLE:=haas-proxy
  URL:=https://haas.nic.cz
  DEPENDS:=+python-base +python-twisted +python-crypto +python-service-identity +server-uplink +sshpass
  CONFLICTS:=mitmproxy
endef

define Package/haas-proxy/description
HaaS proxy application forwards incoming traffic from port 22 (commonly used
for SSH) to the HaaS server, where Cowrie honeypot simulates a device and
records executed commands.
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix=/usr --root=$(PKG_INSTALL_DIR))
	$(INSTALL_DIR) $(PKG_INSTALL_DIR)/etc/init.d/
	$(INSTALL_DIR) $(PKG_INSTALL_DIR)/etc/config
	$(INSTALL_DATA) ./files/haas.uci $(PKG_INSTALL_DIR)/etc/config/haas
	$(INSTALL_BIN) ./files/init $(PKG_INSTALL_DIR)/etc/init.d/haas-proxy
	$(INSTALL_DIR) $(PKG_INSTALL_DIR)/usr/share/haas/
	$(INSTALL_BIN) ./files/register.sh $(PKG_INSTALL_DIR)/usr/share/haas/register.sh
	$(INSTALL_DIR) $(PKG_INSTALL_DIR)/etc/cron.d
	$(INSTALL_DATA) ./files/haas.cron $(PKG_INSTALL_DIR)/etc/cron.d/haas
endef

define Package/haas-proxy/conffiles
/etc/config/haas
endef

define Package/haas-proxy/install
	$(INSTALL_DIR) $(1)
	$(CP) \
		$(PKG_INSTALL_DIR)/* \
		$(1)
endef

define Package/haas-proxy/prerm
	/etc/init.d/haas-proxy stop || true
	/etc/init.d/haas-proxy disable || true
endef

$(eval $(call BuildPackage,haas-proxy))
