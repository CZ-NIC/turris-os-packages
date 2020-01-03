# Copyright (C) 2018-2019 CZ.NIC, z.s.p.o.
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=msgpack-c
PKG_VERSION:=3.2.1
PKG_RELEASE=1

PKG_SOURCE:=msgpack-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/msgpack/msgpack-c/releases/download/cpp-$(PKG_VERSION)/
PKG_HASH:=433cbcd741e1813db9ae4b2e192b83ac7b1d2dd7968a3e11470eacc6f4ab58d2

PKG_BUILD_DIR:=$(BUILD_DIR)/msgpack-$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=BSL-1.0
PKG_LICENSE_FILES:=LICENSE_1_0.txt

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/msgpack-c
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Msgpack C/C++ library
  DEPENDS:=
endef

define Build/InstallDev
	$(CP) $(PKG_INSTALL_DIR)/* $(1)/
endef

define Package/msgpack-c/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libmsgpackc.so* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,msgpack-c))
