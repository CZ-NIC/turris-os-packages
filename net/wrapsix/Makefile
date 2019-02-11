#
# Copyright (C) 2006-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=wrapsix
PKG_VERSION:=0.2.1
PKG_RELEASE:=0

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=https://www.wrapsix.org/download/
PKG_MD5SUM:=8f2496dc68210a7f617c196b77ba6de548c5fc8bd0f90a66f6c9e0ec1451696e

PKG_LICENSE:=GPL-3.0

PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/wrapsix
  SUBMENU:=IP Addresses and Names
  SECTION:=net
  CATEGORY:=Network
  TITLE:=The fastest software NAT64
  MAINTAINER:=CZ.NIC <packaging@turris.cz>
  URL:=https://www.wrapsix.org/
endef

define Package/wrapsix/description
  WrapSix is a NAT64. It’s implemented in userspace, currently only for Linux.
  There isn’t any dependency on external library (currently, may change later).

  So far it’s the fastest available software implementation of NAT64 – faster
  than kernelspace Ecdysis, faster than userspace stateless Tayga.
endef

define Package/schnapps/conffiles
/etc/wrapsix.conf
endef

define default_iface
	sed -i 's|#interface.*|interface br-lan|' $(PKG_BUILD_DIR)/wrapsix.conf
endef

define Package/wrapsix/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/wrapsix $(1)/usr/sbin
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/wrapsix.conf $(1)/etc/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/wrapsix.init $(1)/etc/init.d/wrapsix
endef

$(eval $(call BuildPackage,wrapsix))
