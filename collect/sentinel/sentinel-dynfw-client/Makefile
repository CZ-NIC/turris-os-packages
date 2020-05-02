#
# Copyright (C) 2018-2020 CZ.NIC, z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=sentinel-dynfw-client
PKG_VERSION:=1.3
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/sentinel/dynfw-client.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later

include $(INCLUDE_DIR)/package.mk

define Package/sentinel-dynfw-client
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Sentinel
  TITLE:=Dynamic firewall client
  DEPENDS:=+python3-light +python3-zmq +ipset +python3-msgpack
endef

define Package/sentinel-dynfw-client/description
  Sentinel dynamic firewall client. Receives updates of firewall rules and updates
  firewall accordingly.
endef

Build/Compile:=:
Build/Install:=:

define Package/sentinel-dynfw-client/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/client.py $(1)/usr/bin/sentinel-dynfw-client
	$(INSTALL_DIR) $(1)/etc/
	$(INSTALL_BIN) ./files/server.pub $(1)/etc/sentinel_dynfw.pub
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) files/init $(1)/etc/init.d/sentinel-dynfw-client
	$(INSTALL_BIN) files/ipset.init $(1)/etc/init.d/sentinel-dynfw-ipset
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/uci-defaults $(1)/etc/uci-defaults/99-sentinel-dynfw-client
endef

$(eval $(call BuildPackage,sentinel-dynfw-client))
