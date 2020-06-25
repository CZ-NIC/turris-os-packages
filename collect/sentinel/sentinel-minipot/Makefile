#
## Copyright (C) 2018-2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=sentinel-minipot
PKG_VERSION:=1
PKG_RELEASE:=10
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/sentinel/minipot.git
PKG_SOURCE_VERSION:=ebc6c8f96202b6c122fcc8f94b9413ec6bfd2e4f

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later

PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/sentinel-minipot
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Sentinel
  TITLE:=Minipots
  URL:=https://gitlab.labs.nic.cz/turris/sentinel/minipot
  DEPENDS:=\
    +czmq \
    +libevent2 \
    +msgpack-c \
    +sentinel-firewall \
    +sentinel-proxy
endef

define Package/sentinel-minipot/description
  Sentinel minipots. These are minimal honeypots. Implements protocols: telnet
endef

define Package/sentinel-minipot/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/sentinel_minipot $(1)/usr/bin/sentinel-minipot

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/init $(1)/etc/init.d/sentinel-minipot
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/uci-defaults $(1)/etc/uci-defaults/99-sentinel-minipot-telnet
	$(INSTALL_DIR) $(1)/usr/libexec/sentinel/firewall.d
	$(INSTALL_BIN) ./files/sentinel-firewall.sh $(1)/usr/libexec/sentinel/firewall.d/70-minipot.sh

	$(INSTALL_DIR) $(1)/usr/libexec/sentinel/reload_hooks.d
	$(INSTALL_BIN) ./files/restart-minipot-hook.sh $(1)/usr/libexec/sentinel/reload_hooks.d/60_minipot.sh
endef

$(eval $(call BuildPackage,sentinel-minipot))
