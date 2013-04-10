# 
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=squashfs-tools
PKG_VERSION:=4.2
PKG_RELEASE:=1

PKG_SOURCE:=squashfs$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=@SF/squashfs
PKG_MD5SUM:=1b7a781fb4cf8938842279bd3e8ee852
PKG_CAT:=zcat

PKG_BUILD_DIR:=$(BUILD_DIR)/squashfs$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/squashfs-tools
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=squashfs-tools
  DEPENDS+= +libpthread +zlib
  MENU:=1
endef

define Package/squashfs-tools/config
	source "$(SOURCE)/Config.in"
endef

define Build/Configure
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR)/squashfs-tools \
		CC="$(TARGET_CC)" \
		EXTRA_CFLAGS="$(TARGET_CFLAGS)" \
		EXTRA_LDFLAGS="$(TARGET_LDFLAGS)" \
		XATTR_SUPPORT= \
		mksquashfs unsquashfs
endef

define Package/squashfs-tools/install
	$(INSTALL_DIR) $(1)/usr/sbin
ifeq ($(CONFIG_SQUASHFS_TOOLS_MKSQUASHFS),y)
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/squashfs-tools/mksquashfs $(1)/usr/sbin/mksquashfs
endif
ifeq ($(CONFIG_SQUASHFS_TOOLS_UNSQUASHFS),y)
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/squashfs-tools/unsquashfs $(1)/usr/sbin/unsquashfs
endif
endef

$(eval $(call BuildPackage,squashfs-tools))
