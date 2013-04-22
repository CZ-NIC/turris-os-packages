# 
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=squashfs-tools
PKG_VERSION:=4.2
PKG_RELEASE:=4

PKG_SOURCE:=squashfs$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=@SF/squashfs
PKG_MD5SUM:=1b7a781fb4cf8938842279bd3e8ee852

PKG_CAT:=zcat
PKG_BUILD_PARALLEL:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/squashfs$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/squashfs-tools/Default
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=squashfs-tools
  DEPENDS += +libpthread +zlib \
	+SQUASHFS_TOOLS_LZO_SUPPORT:liblzo \
	+SQUASHFS_TOOLS_XZ_SUPPORT:liblzma
endef

define Package/squashfs-tools-mksquashfs
  $(call Package/squashfs-tools/Default)
  TITLE+= mksquashfs
endef

define Package/squashfs-tools-unsquashfs
  $(call Package/squashfs-tools/Default)
  TITLE+= unsquashfs
endef

define Package/squashfs-tools-unsquashfs/config
	source "$(SOURCE)/Config.in"
endef

define Build/Configure
endef

SQUASHFS_TOOLS_CONFIG := \
	'XATTR_SUPPORT='

ifneq ($(CONFIG_SQUASHFS_TOOLS_XZ_SUPPORT),)
SQUASHFS_TOOLS_CONFIG += 'XZ_SUPPORT=1'
endif

ifneq ($(CONFIG_SQUASHFS_TOOLS_LZO_SUPPORT),)
SQUASHFS_TOOLS_CONFIG += 'LZO_SUPPORT=1'
endif

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR)/squashfs-tools \
		CC="$(TARGET_CC)" \
		EXTRA_CFLAGS="$(TARGET_CFLAGS)" \
		EXTRA_LDFLAGS="$(TARGET_LDFLAGS)" \
		$(SQUASHFS_TOOLS_CONFIG) \
		mksquashfs unsquashfs
endef

define Package/squashfs-tools-mksquashfs/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/squashfs-tools/mksquashfs $(1)/usr/sbin/mksquashfs
endef

define Package/squashfs-tools-unsquashfs/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/squashfs-tools/unsquashfs $(1)/usr/sbin/unsquashfs
endef

$(eval $(call BuildPackage,squashfs-tools-mksquashfs))
$(eval $(call BuildPackage,squashfs-tools-unsquashfs))
