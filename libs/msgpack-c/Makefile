# Copyright (C) 2018 CZ.NIC, z.s.p.o.
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=msgpack-c
PKG_VERSION:=2.1.5
PKG_RELEASE=1

PKG_SOURCE:=cpp-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/msgpack/msgpack-c/archive
PKG_BUILD_DIR:=$(BUILD_DIR)/msgpack-c-cpp-$(PKG_VERSION)
PKG_MD5SUM:=6536e2072a1006e2004e2963081692a2
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf
PKG_BUILD_PARALLEL:=1
PKG_LICENSE:=Boost Software Licence

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/msgpack-c
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Msgpack C/C++ library
  DEPENDS:=
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) CFLAGS="$(TARGET_CFLAGS) $(EXTRA_CFLAGS) $(TARGET_CPPFLAGS) $(EXTRA_CPPFLAGS)"
endef

define Build/InstallDev
	$(CP) $(PKG_INSTALL_DIR)/* $(1)/
endef

define Package/msgpack-c/install
	true
	#$(INSTALL_DIR) $(1)/usr/lib
	#$(CP) $(PKG_INSTALL_DIR)/usr/lib/libpaho-*.so* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,msgpack-c))
