#
# Copyright (C) 2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=haas-proxy
PKG_VERSION:=2.0.2
PKG_RELEASE:=1

PKG_SOURCE:=proxy-v$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://gitlab.nic.cz/haas/proxy/-/archive/v$(PKG_VERSION)/
PKG_HASH:=42bc51b8ef221516136987656c238b4b7132c3864fdc251ace8dddb91542c54a
PKG_BUILD_DIR:=$(BUILD_DIR)/proxy-v$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/haas-proxy
  SECTION:=net
  CATEGORY:=Network
  TITLE:=haas-proxy
  URL:=https://haas.nic.cz
  DEPENDS:=+python-base +python-cachetools +python-requests +python-twisted +python-crypto +python-service-identity +server-uplink +sshpass
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
	$(INSTALL_DIR) $(PKG_INSTALL_DIR)/etc/firewall.d/with_reload
	$(INSTALL_BIN) ./files/haas.fw $(PKG_INSTALL_DIR)/etc/firewall.d/with_reload/99_haas.fw
endef

define Package/haas-proxy/conffiles
/etc/config/haas
endef

define Package/haas-proxy/install
	$(INSTALL_DIR) $(1)
	$(CP) \
		$(PKG_INSTALL_DIR)/* \
		$(1)
	$(RM) -rf $(1)/usr/lib/python2.7/site-packages/haas_proxy-1.*
endef

define Package/haas-proxy/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/haas-proxy enable || true
/usr/share/haas/register.sh || true
}
endef

define Package/haas-proxy/prerm
#!/bin/sh
/etc/init.d/haas-proxy stop || true
/etc/init.d/haas-proxy disable || true
endef

$(eval $(call BuildPackage,haas-proxy))
