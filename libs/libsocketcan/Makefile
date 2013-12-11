#
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libsocketcan
PKG_VERSION:=0.0.9
PKG_RELEASE=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://www.pengutronix.de/software/libsocketcan/download/
PKG_MD5SUM:=cd92766be40d98b5cb08366b71ea4663

include $(INCLUDE_DIR)/package.mk

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/libsocketcan
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=libsocketcan
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/can_netlink.h $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/libsocketcan.h $(1)/usr/include
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libsocketcan.{a,so*} $(1)/usr/lib
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/libsocketcan.pc $(1)/usr/lib/pkgconfig
endef

define Package/libsocketcan/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libsocketcan.so* $(1)/usr/lib
endef

$(eval $(call BuildPackage,libsocketcan))
