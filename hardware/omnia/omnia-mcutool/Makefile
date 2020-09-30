#
# Copyright (C) 2016-2020 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
PKG_NAME:=omnia-mcutool
PKG_VERSION:=0.1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/omnia-mcutool.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-2.0-or-later

include $(INCLUDE_DIR)/package.mk

define Package/omnia-mcutool
  TITLE:=mcutool
  DEPENDS:=@TARGET_mvebu_cortexa9_DEVICE_cznic_turris-omnia
  PROVIDES:=mcutool
endef

define Package/omnia-mcutool/description
  Utility update mcu on Omnias, dangerous, could brick your device.
endef

define Build/Compile
	$(TARGET_CC) $(TARGET_CFLAGS) $(EXTRA_CFLAGS) $(EXTRA_LDFLAGS) $(TARGET_LDFLAGS) \
		-o $(PKG_BUILD_DIR)/mcutool \
		$(PKG_BUILD_DIR)/mcutool/mcutool.c
endef

define Package/omnia-mcutool/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mcutool/mcutool $(1)/usr/bin/
endef

$(eval $(call BuildPackage,omnia-mcutool))
