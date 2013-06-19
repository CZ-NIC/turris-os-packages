#
## Copyright (C) 2013 CZ.NIC z.s.p.o. <martin.strbacka@nic.cz>
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=libnetconf
PKG_VERSION:=1
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=ssh://git@git.nic.cz/router/libnetconf
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=d0de34a63d9336b296b12dca07dd65b374a9413f
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Martin Strbacka <martin.strbacka@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/libnetconf
	TITLE:=libnetconf
	DEPENDS:=+libreadline +libevent +libxml2
endef

define Build/Configure
	$(call Build/Configure/Default, --disable-libssh2 --disable-notifications)
endef

define Package/libnetconf/install
	$(INSTALL_DIR) $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/libnetconf.so $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/libnetconf.so.0.5 $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/libnetconf.so.0.5.0 $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libnetconf))
