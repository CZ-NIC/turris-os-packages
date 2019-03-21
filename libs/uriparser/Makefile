#
## Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=uriparser
PKG_VERSION:=0.9.1
PKG_RELEASE:=1

PKG_SOURCE:=uriparser-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/uriparser/uriparser/archive
PKG_HASH:=2d241d771368fb341c5d7231c2a754d4a5fa1280b958b82131dd7838900dc976
PKG_BUILD_DIR:=$(BUILD_DIR)/uriparser-uriparser-$(PKG_VERSION)
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_URL:=https://uriparser.github.io

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/autotools.mk


define Package/uriparser
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=uriparser
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

CONFIGURE_ARGS += \
		--disable-test \
		--disable-doc \
		--disable-wchar_t

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

$(eval $(call BuildPackage,uriparser))
$(eval $(call BuildPackage,liburiparser))
