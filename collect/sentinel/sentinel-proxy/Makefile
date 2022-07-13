#
## Copyright (C) 2018-2021 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=sentinel-proxy
PKG_VERSION:=1.4
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/sentinel/proxy.git
PKG_MIRROR_HASH:=fd595c07673f23bf4ce54fb5bf28f03bc15c63eb8a7adfff9948e184085cf288
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later

PKG_FIXUP:=autoreconf
PKG_INSTALL:=y

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
    +msgpack-c \
    +sentinel-certgen \
    +sentinel-eula
endef

define Package/sentinel-proxy/description
  Central daemon proxying all Sentinel trafic on router to Turris servers.
endef

define Package/sentinel-proxy/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/sentinel-proxy $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/sentinel-device-token $(1)/usr/bin/
	$(INSTALL_BIN) ./files/sentinel-reload.sh $(1)/usr/bin/sentinel-reload
	$(INSTALL_BIN) ./files/sentinel-status.sh $(1)/usr/bin/sentinel-status

	$(INSTALL_DIR) $(1)/usr/lib/ $(1)/lib/functions/
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/lib/libsentinel-device-token.so* $(1)/usr/lib/
	$(INSTALL_DATA) ./files/sentinel.sh $(1)/lib/functions/sentinel.sh

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/init $(1)/etc/init.d/sentinel-proxy

	$(INSTALL_DIR) $(1)/etc/cron.d
	$(INSTALL_DATA) ./files/renew.cron $(1)/etc/cron.d/certgen-certs-renew

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/uci $(1)/etc/config/sentinel

	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_DATA) ./files/uci-defaults $(1)/etc/uci-defaults/99-sentinel-main

	$(INSTALL_DIR) $(1)/etc/sentinel
	$(INSTALL_DATA) ./files/ca.pem $(1)/etc/sentinel/ca.pem

	$(INSTALL_DIR) $(1)/usr/libexec/sentinel/renew_hooks.d
	$(INSTALL_BIN) ./files/restart-proxy-hook.sh $(1)/usr/libexec/sentinel/renew_hooks.d/50_proxy_restart.sh

	$(INSTALL_DIR) $(1)/usr/libexec/sentinel/reload_hooks.d
	$(INSTALL_BIN) ./files/restart-proxy-hook.sh $(1)/usr/libexec/sentinel/reload_hooks.d/50_proxy.sh

	$(INSTALL_DIR) $(1)/usr/libexec/sentinel/status.d
	$(INSTALL_BIN) ./files/status.d/00-proxy.sh $(1)/usr/libexec/sentinel/status.d/00-proxy.sh
	$(INSTALL_DATA) ./files/status.d/common.sh $(1)/usr/libexec/sentinel/status.d/common.sh
endef

define Package/sentinel-proxy/conffiles
/etc/config/sentinel
endef

$(eval $(call BuildPackage,sentinel-proxy))
