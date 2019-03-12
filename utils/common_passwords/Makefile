#
# Copyright (C) 2019 CZ.NIC z.s.p.o
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=common_passwords
PKG_VERSION:=20181218
PKG_RELEASE:=1
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-2.0

include $(INCLUDE_DIR)/package.mk

define Package/common_passwords
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=List of commonly used paswords
endef

define Package/common_passwords/description
 This package provides lists of commonly used passwords users can check their passwords against.
endef

define Build/Compile
	true
endef

define Package/common_passwords/install
	$(INSTALL_DIR) $(1)/usr/share/common_passwords
	$(INSTALL_DATA) ./files/* $(1)/usr/share/common_passwords
endef

$(eval $(call BuildPackage,common_passwords))
