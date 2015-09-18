#
# Copyright (C) 2015 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=knot-resolver
PKG_VERSION:=dev20150918
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/knot/resolver.git
PKG_SOURCE_VERSION:=26774309fee97ec29f038fe1f624d59f85aedcb9
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_MAINTAINER:=Jan Cermak <jan.cermak@nic.cz>
PKG_LICENSE:=GPL-3.0

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/knot-resolver
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=IP Addresses and Names
	TITLE:=Knot DNS Resolver
	URL:=https://gitlab.labs.nic.cz/knot/resolver
	DEPENDS=+knot-libknot +libuv +liblua
endef

define Package/knot-resolver/description
  The Knot DNS Resolver is a minimalistic caching resolver implementation.
endef

MAKE_FLAGS += \
	PREFIX=$(PKG_INSTALL_DIR)/usr

define Package/knot-resolver/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/kresd $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,knot-resolver))
