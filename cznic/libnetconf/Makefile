#
## Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=libnetconf
PKG_VERSION:=11
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/libnetconf.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=b517ec653f3355ada26cb995b30dbdaac6f7875a
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Martin Strbacka <martin.strbacka@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=libnetconf
	DEPENDS:= +libevent +libxml2 +libxslt +libcurl +zlib +libpthread +libopenssl
endef

define Build/Configure
	$(call Build/Configure/Default, --disable-libssh2 --disable-notifications  --prefix=/usr/ --exec-prefix=/usr --with-ncworkingdirpath=/tmp/ --with-workingdir=/tmp/)
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/headers/libnetconf*.h $(1)/usr/include/

	$(INSTALL_DIR) $(1)/usr/include/libnetconf
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/*.h $(1)/usr/include/libnetconf/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/transapi/*.h $(1)/usr/include/libnetconf/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/datastore/custom/*.h $(1)/usr/include/libnetconf/

	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/.libs/libnetconf.{so*,a} $(1)/usr/lib/

	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/libnetconf.pc $(1)/usr/lib/pkgconfig/
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/.libs/libnetconf.{a,so*} $(1)/usr/lib/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
