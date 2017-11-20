#
# Copyright (C) 2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=lime
PKG_VERSION:=1.7.8
PKG_RELEASE=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/504ensicsLabs/LiME.git

PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1
PKG_LICENSE:=GPL-2.0


#PKG_MD5SUM:=148888a7c95ac23705559b6f477dfe25
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_LICENSE:=GPL-2.0)

PKG_LICENSE:=GPL-3.0+
PKG_LICENSE_FILES:=COPYING
PKG_MAINTAINER:=Jan Pavlinec <jan.pavlinec@nic.cz>

PKG_CHECK_FORMAT_SECURITY:=0
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/kernel.mk

define Package/lime
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=LiME (Linux Memory Extractor)
  URL:=https://github.com/504ensicsLabs/lime
endef

define Package/lime/description
  LiME A Loadable Kernel Module (LKM) which allows for volatile memory acquisition from Linux and Linux-based devices
endef

define Build/Prepare
	$(call Build/Prepare/Default)
endef

define Build/Compile
	cd $(PKG_BUILD_DIR)/src && KERNEL_ARCH=$(LINUX_KARCH) KERNEL_CROSS_COMPILE=$(KERNEL_CROSS) KERNEL_SRC_DIR=$(LINUX_DIR) PWD=$(PKG_BUILD_DIR)/src $(MAKE)
endef

define Package/lime/install
	$(INSTALL_DIR) $(1)/usr/bin
endef

$(eval $(call BuildPackage,lime))
