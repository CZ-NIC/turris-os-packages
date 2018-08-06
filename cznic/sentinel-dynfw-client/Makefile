#
# Copyright (C) 2018 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=sentinel-dynfw-client
PKG_VERSION:=1.0
PKG_RELEASE:=1
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/sentinel/dynfw-client.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_MAINTAINER:=Martin Petracek <martin.petracek@nic.cz>
PKG_LICENSE:=GPL-3.0

PKG_INSTALL:=0

include $(INCLUDE_DIR)/package.mk

define Package/sentinel-dynfw-client
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Receives updates of firewall rules and updates firewall accordingly
	TITLE:=Sentinel dynamic firewall client
	DEPENDS:=+python3-light +ipset +python3-msgpack
endef

define Package/$(PKG_NAME)/description
  Sentinel dynamic firewall client
endef

define Build/Compile
  true
endef

define Build/Install
  true
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/
	$(INSTALL_BIN) ./files/server.pub $(1)/etc/sentinel_dynfw.pub
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) files/init $(1)/etc/init.d/sentinel-dynfw-client
	$(INSTALL_DIR) $(1)/etc/firewall.d/with_reload
	$(INSTALL_BIN) ./files/fw_reload $(1)/etc/firewall.d/with_reload/99_sentinel_dynfw.fw
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/client.py $(1)/usr/bin/sentinel-dynfw-client
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
