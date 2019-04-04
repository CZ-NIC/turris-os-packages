#
## Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=argp-standalone
PKG_VERSION:=1.3
PKG_RELEASE:=1

PKG_SOURCE:=argp-standalone-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://www.lysator.liu.se/~nisse/misc
PKG_HASH:=dec79694da1319acd2238ce95df57f3680fea2482096e483323fddf3d818d8be
PKG_BUILD_DIR:=$(BUILD_DIR)/argp-standalone-$(PKG_VERSION)
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/libargp.a $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_BUILD_DIR)/argp.h $(1)/usr/include/
endef

$(eval $(call Build/DefaultTargets))
