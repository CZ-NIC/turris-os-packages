#
## Copyright (C) 2018-2020 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=sentinel-proxy
PKG_VERSION:=1.3.1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/sentinel/proxy.git
PKG_MIRROR_HASH:=ad97d890976fbace6a05c5dff42360b9a0ec47f3c001e068430695491aac2d16
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later

PKG_FIXUP:=autoreconf

PKG_BUILD_DEPENDS:=argp-standalone

include $(INCLUDE_DIR)/package.mk

define Package/sentinel-proxy
  SECTION:=collect
  CATEGORY:=Collect
  SUBMENU:=Sentinel
  TITLE:=Proxy
  URL:=https://gitlab.nic.cz/turris/sentinel/proxy
  DEPENDS:= \
    +czmq \
    +libpaho-mqtt-c \
    +zlib \
    +libopenssl \
    +libconfig \
    +sentinel-certgen \
    +sentinel-eula
endef

define Package/sentinel-proxy/description
  Central daemon proxying all Sentinel trafic on router to Turris servers.
endef

define Package/sentinel-proxy/install
	$(INSTALL_DIR) $(1)/lib/functions/
	$(INSTALL_CONF) ./files/sentinel.sh $(1)/lib/functions/sentinel.sh

	$(INSTALL_DIR) $(1)/etc/sentinel
	$(INSTALL_DATA) ./files/ca.pem $(1)/etc/sentinel/ca.pem

	$(INSTALL_DIR) $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/.libs/libsentinel-device-token.so.1.0.0 $(1)/usr/lib/libsentinel-device-token.so.1

	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/.libs/sentinel-proxy $(1)/usr/bin/sentinel-proxy

	$(INSTALL_BIN) $(PKG_BUILD_DIR)/.libs/sentinel-device-token $(1)/usr/bin/sentinel-device-token

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/init $(1)/etc/init.d/sentinel-proxy

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_BIN) ./files/uci $(1)/etc/config/sentinel

	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/uci-defaults $(1)/etc/uci-defaults/99-sentinel-main

	$(INSTALL_BIN) ./files/sentinel-reload.sh $(1)/usr/bin/sentinel-reload

	$(INSTALL_DIR) $(1)/usr/libexec/sentinel/renew_hooks.d
	$(INSTALL_BIN) ./files/restart-proxy-hook.sh $(1)/usr/libexec/sentinel/renew_hooks.d/50_proxy_restart.sh

	$(INSTALL_DIR) $(1)/usr/libexec/sentinel/reload_hooks.d
	$(INSTALL_BIN) ./files/restart-proxy-hook.sh $(1)/usr/libexec/sentinel/reload_hooks.d/50_proxy.sh

	$(INSTALL_DIR) $(1)/etc/cron.d
	$(INSTALL_DATA) ./files/renew.cron $(1)/etc/cron.d/certgen-certs-renew
endef

define Package/sentinel-proxy/conffiles
/etc/config/sentinel
endef

$(eval $(call BuildPackage,sentinel-proxy))
