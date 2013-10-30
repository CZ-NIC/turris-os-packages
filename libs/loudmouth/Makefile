#
# Copyright (C) 2011-2013 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libloudmouth1
PKG_VERSION:=1.5.0-20121201
PKG_RELEASE:=1

PKG_SOURCE:=loudmouth-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://mcabber.com/files/
PKG_MD5SUM:=c03025069d376049eee8af4fbaf4d9cf
PKG_BUILD_DIR:=$(BUILD_DIR)/loudmouth-$(PKG_VERSION)

PKG_INSTALL:=1

PKG_BUILD_DEPENDS:=libopenssl

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/libloudmouth1
	SECTION:=libs
	CATEGORY:=Libraries
	DEPENDS:=+libopenssl +glib2
	TITLE:=Lightweight C Jabber library
	URL:=http://mcabber.com
	MAINTAINER:=Peter Wagner <tripolar@gmx.at>
endef

define Package/libloudmouth1/description
  Loudmouth is a lightweight and easy-to-use C library for programming with the
  Jabber protocol. It's designed to be easy to get started with and yet
  extensible to let you do anything the Jabber protocol allows.
endef

CONFIGURE_VARS += \
	ac_cv_path_KRB5CONFIG=no \
	LIBS="-liconv -lgobject-2.0"

CONFIGURE_ARGS += \
	--with-compile-warnings=no \
	--with-ssl=openssl

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/loudmouth-1.0/loudmouth
	$(CP) $(PKG_INSTALL_DIR)/usr/include/loudmouth-1.0/loudmouth/*.h $(1)/usr/include/loudmouth-1.0/loudmouth
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libloudmouth-1.{a,la,so*} $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/loudmouth-1.0.pc $(1)/usr/lib/pkgconfig/
endef

define Package/libloudmouth1/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/loudmouth/.libs/libloudmouth-1.so* $(1)/usr/lib
endef

$(eval $(call BuildPackage,libloudmouth1))
