#
# Copyright (C) 2022 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=morce
PKG_VERSION:=1.0.1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/morce.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_MIRROR_HASH:=a9091d26088a6b2a3e8feefe752eb0165e701d61cf3b8511aa372e91c439fd9a

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=COPYING

include $(INCLUDE_DIR)/package.mk

define Package/morce
  SECTION:=net
  CATEGORY:=Network
  TITLE:=MORCE - Simple IDS integration
  DEPENDS:=+libuci-lua +luasql-sqlite3 +snort3 +sqlite3-cli +tar +wget-ssl
endef

define Package/morce/description
  Simple integration of Snort IDS into Turris OS
endef

Build/Compile:=:

define Package/morce/install
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/init/morce $(1)/etc/init.d/morce

	$(INSTALL_DIR) $(1)/usr/share/morce/loggers/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/logger/alert_morce.lua $(1)/usr/share/morce/loggers/

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/uci/morce $(1)/etc/config
endef

define Package/morce/conffiles
/etc/config/morce
endef

$(eval $(call BuildPackage,morce))
