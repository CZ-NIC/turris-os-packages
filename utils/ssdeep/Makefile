#
# Copyright (C) 2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ssdeep
PKG_VERSION:=2.14.1
PKG_RELEASE=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/ssdeep-project/ssdeep.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=release-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_MD5SUM:=6cef4cfcd9084e47a1315f5f4a39358c40707ed6d2e83c1a001db63f3a06b5c0

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf
PKG_BUILD_PARALLEL:=1
PKG_LICENSE:=GPL-2.0
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/ssdeep
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=A program to compute and match fuzzy hashes
  URL:=https://ssdeep-project.github.io/ssdeep
  DEPENDS:=+libstdcpp
endef

define Package/ssdeep/description
 ssdeep is a program for computing context triggered piecewise hashes (CTPH). Also called fuzzy hashes, CTPH can match inputs that have homologies.
endef

define Package/ssdeep/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_BUILD_DIR)/ssdeep $(1)/usr/bin/
endef

$(eval $(call BuildPackage,ssdeep))
