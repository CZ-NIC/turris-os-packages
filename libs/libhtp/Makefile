
#
# Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libhtp
PKG_VERSION:=0.5.31
PKG_RELEASE=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/OISF/libhtp/tar.gz/$(PKG_VERSION)?
PKG_HASH:=ce16a3e57c7d1f1e8255a4f698e22ddd33c15fb4e737ab90b04c9a1f07e48780

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=BSD 3-Clause
PKG_LICENSE_FILES:=LICENSE
PKG_CPE_ID:=cpe:/a:oisf:libhtp

PKG_BUILD_DEPENDS:=libiconv-full

include $(INCLUDE_DIR)/package.mk

define Package/libhtp
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=HTTP normalizer and parser library
  URL:=https://github.com/OISF/libhtp
  DEPENDS:= \
	+libiconv-full \
	+zlib
endef

define Package/libhtp/description
  LibHTP is a security-aware parser for the HTTP protocol and the related bits and pieces.
endef

TARGET_CFLAGS += -I$(STAGING_DIR)/usr/lib/libiconv-full/include
TARGET_LDFLAGS += -L$(STAGING_DIR)/usr/lib/libiconv-full/lib
CONFIGURE_ARGS += --disable-static

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
