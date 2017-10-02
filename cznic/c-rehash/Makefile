#
## Copyright (C) 2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=c-rehash
PKG_VERSION:=1.7
PKG_RELEASE:=3
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+openssl-util
endef

define Build/Compile
	true
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/openssl-c_rehash.sh $(1)/usr/bin/c_rehash
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
