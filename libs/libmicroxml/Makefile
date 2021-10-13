#
# Copyright (C) 2021 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libmicroxml
PKG_VERSION:=2018-06-14
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/pivasoftware/microxml.git
PKG_MIRROR_HASH:=bce6c08f273319f3468e71ca149f8c331a8cde9451b3e2056fe90c2401477810
PKG_SOURCE_VERSION:=80a15162f3a8318c70e8688d8ecbfc38676bd9a2

PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/libmicroxml
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=The Mini-XML library
  URL:=http://libevent.org
endef

define Package/libmicroxml/description
	microxml is a small XML parsing library that you can use to read XML and
	XML-like data files in your application without requiring large non-standard
	libraries.  microxml only requires an ANSI C compatible compiler (GCC works,
	as do most vendors' ANSI C compilers) and a "make" program.
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_BUILD_DIR)/*.h $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/libmicro*.so* $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_BUILD_DIR)/*.pc $(1)/usr/lib/pkgconfig/
endef

define Package/libmicroxml/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/libmicroxml.so.* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libmicroxml))

