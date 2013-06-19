#
## Copyright (C) 2013 CZ.NIC z.s.p.o. <martin.strbacka@nic.cz>
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=libnetconf
PKG_VERSION:=3
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
	DEPENDS:= +libevent +libxml2
endef

define Build/Configure
	$(call Build/Configure/Default, --disable-libssh2 --disable-notifications  --prefix=/usr/ --exec-prefix=/usr)
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/headers/libnetconf*.h $(1)/usr/include/

	$(INSTALL_DIR) $(1)/usr/include/libnetconf
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/*.h $(1)/usr/include/libnetconf/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/transapi/*.h $(1)/usr/include/libnetconf/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/datastore/custom/*.h $(1)/usr/include/libnetconf/

	$(INSTALL_DIR) $(1)/usr/lib 
	$(CP) $(PKG_BUILD_DIR)/libnetconf.{so*,a} $(1)/usr/lib/

	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/libnetconf.pc $(1)/usr/lib/pkgconfig/
endef

define Package/libnetconf/install
	$(INSTALL_DIR) $(1)/usr/lib/
	$(CP) $(PKG_BUILD_DIR)/libnetconf.{a,so*} $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libnetconf))
