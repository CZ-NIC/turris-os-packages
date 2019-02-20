#
# Copyright (C) 2016 CZ.NIC
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
PKG_NAME:=mcutool
PKG_VERSION:=0.1
PKG_RELEASE:=1
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/misc.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=3d1e674fc992ded2a517a0a40a06edc4bdabc952
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
PKG_MAINTAINER:=Michal Hrusecky <michal.hrusecky@nic.cz>
PKG_LICENSE:=GPL-2.0

include $(INCLUDE_DIR)/package.mk

define Package/mcutool
  TITLE:=mcutool
  DEPENDS:=@TARGET_mvebu_Turris-Omnia
endef

define Package/mcutool/description
Utility update mcu on Omnias, dangerous, could brick your device.
endef

define Build/Compile
	$(TARGET_CC) $(TARGET_CFLAGS) $(EXTRA_CFLAGS) $(EXTRA_LDFLAGS) $(TARGET_LDFLAGS) -o $(PKG_BUILD_DIR)/mcutool/mcutool $(PKG_BUILD_DIR)/mcutool/mcutool.c
endef

define Package/mcutool/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mcutool/mcutool $(1)/usr/bin/
endef

$(eval $(call BuildPackage,mcutool))
