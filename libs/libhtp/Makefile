
# Copyright (C) 2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libhtp
PKG_VERSION:=0.5.25
PKG_RELEASE=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/OISF/libhtp.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf
PKG_BUILD_PARALLEL:=1
PKG_LICENSE:=GPL-2.0

PKG_BUILD_DEPENDS:=libiconv-full

include $(INCLUDE_DIR)/package.mk

TARGET_CFLAGS += -I$(STAGING_DIR)/usr/lib/libiconv-full/include
TARGET_LDFLAGS += -L$(STAGING_DIR)/usr/lib/libiconv-full/lib
CONFIGURE_ARGS += --disable-static

define Package/libhtp
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=HTP Library
  DEPENDS:=+libiconv-full +zlib
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) CFLAGS="$(TARGET_CFLAGS) $(EXTRA_CFLAGS) $(TARGET_CPPFLAGS) $(EXTRA_CPPFLAGS) -fno-stack-protector"
endef

define Build/InstallDev
	sed -i 's|^Libs:\(.*\)*|Libs:\1 -liconv '"-L$(STAGING_DIR)/usr/lib/libiconv-full/lib"'|' $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/htp.pc
	sed -i 's|^prefix=\(.*\)*|prefix='"$(STAGING_DIR)"'\1|' $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/htp.pc
	$(CP) $(PKG_INSTALL_DIR)/* $(1)/
endef

define Package/libhtp/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libhtp*.so* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libhtp))
