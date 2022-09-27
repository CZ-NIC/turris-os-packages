include $(TOPDIR)/rules.mk

PKG_NAME:=x265
PKG_VERSION:=3.2.1
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE:=$(PKG_NAME)_$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://ftp.videolan.org/pub/videolan/x265
PKG_HASH:=fb9badcf92364fd3567f8b5aa0e5e952aeea7a39a2b864387cec31e3b58cbbcc
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)_$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=COPYING

CMAKE_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

CMAKE_BINARY_DIR:=$(PKG_BUILD_DIR)/build
CMAKE_SOURCE_DIR:=$(PKG_BUILD_DIR)/source
MAKE_PATH:=build
TARGET_CFLAGS+= -fPIC
TARGET_CXXFLAGS+= -fPIC

define Package/libx265
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=H265/HEVC free codec library
  DEPENDS:=+libpthread @BUILD_PATENTED +libstdcpp
  URL:=https://www.videolan.org/developers/x265.html
endef

define Package/libx265/description
  x265 is a free software library and application for encoding
  video streams into the H.265/MPEG-H HEVC compression format.
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/x265/
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/include/* $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/*.so* $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig/
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/* $(1)/usr/lib/pkgconfig/
endef

define Package/libx265/install
	$(INSTALL_DIR) $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/*.so* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libx265))
