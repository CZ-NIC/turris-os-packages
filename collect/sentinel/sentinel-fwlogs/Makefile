#
## Copyright (C) 2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=sentinel-fwlogs
PKG_VERSION:=0.1.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/sentinel/fwlogs.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_DEPENDS:=argp-standalone

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/sentinel-fwlogs
  SECTION:=collect
  CATEGORY:=Collect
  SUBMENU:=Sentinel
  TITLE:=FWLogs
  URL:=https://gitlab.nic.cz/turris/sentinel/fwlogs
  DEPENDS:=\
    +czmq \
    +msgpack-c \
    +logc +logc-argp \
    +libnetfilter-log \
    +sentinel-firewall +iptables-mod-nflog \
    +sentinel-proxy
  PROVIDES:=sentinel-nikola
  CONFLICTS:=sentinel-nikola
endef

define Package/sentinel-fwlogs/description
  Collector of firewall logs using libnetfilter-log for Turris Sentinel.
endef

define Package/sentinel-fwlogs/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/sentinel-fwlogs $(1)/usr/bin/sentinel-fwlogs

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/init $(1)/etc/init.d/sentinel-fwlogs

	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/uci-defaults $(1)/etc/uci-defaults/99-sentinel-fwlogs

	$(INSTALL_DIR) $(1)/usr/libexec/sentinel/firewall.d
	$(INSTALL_BIN) ./files/sentinel-firewall.sh $(1)/usr/libexec/sentinel/firewall.d/60-fwlogs.sh
	$(INSTALL_DATA) ./files/defaults.sh $(1)/usr/libexec/sentinel/fwlogs-defaults.sh

	$(INSTALL_DIR) $(1)/usr/libexec/sentinel/reload_hooks.d
	$(INSTALL_BIN) ./files/restart-proxy-hook.sh $(1)/usr/libexec/sentinel/reload_hooks.d/50_nikola.sh
endef

$(eval $(call BuildPackage,sentinel-fwlogs))
