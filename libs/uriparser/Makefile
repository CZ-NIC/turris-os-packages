#
## Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=uriparser
PKG_VERSION:=0.9.4
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/uriparser/uriparser/archive
PKG_HASH:=85ec9a5cc9e00c726c60207ed2b16f28e23d4c353cd1df9d218ac84aee7adec0
PKG_BUILD_DIR:=$(BUILD_DIR)/uriparser-uriparser-$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_INSTALL:=1
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/host-build.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk


define Package/uriparser
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=uriparser
  URL:=https://uriparser.github.io
  DEPENDS:=+liburiparser
endef

define Package/liburiparser
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=liburiparser
endef

define package/uriparser/description
  strictly rfc 3986 compliant uri parser written in c89
endef

define package/liburiparser/description
  strictly rfc 3986 compliant uri parsing and handling library written in c89
endef

CMAKE_OPTIONS := \
	-DBUILD_SHARED_LIBS=ON \
	-DURIPARSER_BUILD_CHAR=ON \
	-DURIPARSER_BUILD_DOCS=OFF \
	-DURIPARSER_BUILD_TESTS=OFF \
	-DURIPARSER_BUILD_TOOLS=ON \
	-DURIPARSER_BUILD_WCHAR_T=OFF
CMAKE_HOST_OPTIONS := $(CMAKE_OPTIONS)

define Package/uriparser/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/uriparse $(1)/usr/bin/
endef

define Package/liburiparser/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/liburiparser.so* $(1)/usr/lib/
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/* $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/* $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/* $(1)/usr/lib/pkgconfig/
endef

define Host/Install
	$(INSTALL_DIR) $(STAGING_DIR_HOST)/usr/lib
	$(CP) $(HOST_INSTALL_DIR)/usr/lib/* $(STAGING_DIR_HOST)/usr/lib/
	$(INSTALL_DIR) $(STAGING_DIR_HOST)/usr/include
	$(CP) $(HOST_INSTALL_DIR)/usr/include/* $(STAGING_DIR_HOST)/usr/include/
	$(INSTALL_DIR) $(STAGING_DIR_HOST)/usr/lib/pkgconfig
	$(CP) $(HOST_INSTALL_DIR)/usr/lib/pkgconfig/* $(STAGING_DIR_HOST)/usr/lib/pkgconfig/
endef

$(eval $(call HostBuild))
$(eval $(call BuildPackage,uriparser))
$(eval $(call BuildPackage,liburiparser))
