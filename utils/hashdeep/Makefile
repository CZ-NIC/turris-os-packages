#
# Copyright (C) 2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk


PKG_NAME:=hashdeep
PKG_VERSION:=4.4
PKG_RELEASE=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/jessek/hashdeep.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=release-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_MD5SUM:=d78d42142f9a74fe8ec0c61bc78d6588a528cbb9aede9440f50b6ff477f3a7f

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf
PKG_LICENSE:=GPL-2.0
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/hashdeep
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=A program to compute, match and audit hashsets
  URL:=http://md5deep.sourceforge.net/
  DEPENDS:=+libstdcpp +libpthread
endef

define Package/hashdeep/description
 md5deep is a set of programs to compute MD5, SHA-1, SHA-256, Tiger, or
 Whirlpool message digests on an arbitrary number of files.
endef

define Package/hashdeep/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/{hash,md5,sha1,sha256,tiger,whirlpool}deep $(1)/usr/bin/
endef

$(eval $(call BuildPackage,hashdeep))
