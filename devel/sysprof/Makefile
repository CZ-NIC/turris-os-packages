#
# Copyright (C) 2009-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=sysprof
PKG_VERSION:=1.2.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://sysprof.com
PKG_MD5SUM:=a81808d847732f8dafb59d26ec2eebbf

PKG_BUILD_DEPENDS:= glib2
PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/kernel.mk

define Package/sysprof
  SECTION:=devel
  CATEGORY:=Development
  TITLE:=Sysprof System Profiler
  URL:=http://sysprof.com
  DEPENDS:=+glib2
endef


define Package/sysprof/description
	Sysprof is a statistical, system-wide profiler for Linux
endef

define Package/sysprof/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/sysprof-cli $(1)/usr/bin/
endef

$(eval $(call BuildPackage,sysprof))
