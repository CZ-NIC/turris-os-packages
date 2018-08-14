#
## Copyright (C) 2018 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=sentinel-proxy
PKG_VERSION:=1
PKG_RELEASE:=1
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/sentinel/proxy.git
PKG_SOURCE_VERSION:=578d86aa4e0377c407a9656f77caef712611e083
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Martin Petracek <martin.petracek@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+czmq +libpaho-mqtt-c +zlib +libopenssl +sentinel-certgen
endef

define Build/Compile

	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS)
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/sentinel_proxy $(1)/usr/bin/sentinel-proxy
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) files/init $(1)/etc/init.d/sentinel-proxy
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
