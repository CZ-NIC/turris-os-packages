#
## Copyright (C) 2018-2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=mox-uboot
PKG_VERSION:=2021-01-rc1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/mox-boot-builder.git
PKG_MIRROR_HASH:=ffc040670f801ee0de390d0b9fe8e30d8afd6ebea7da2c8d895608941a08e015
PKG_SOURCE_VERSION:=b0959e4d326fa3ae118afef931f6465f7b833bc3

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=README

include $(INCLUDE_DIR)/package.mk

define Package/mox-uboot
  TITLE:=U-boot for Turris MOX
  DEPENDS:=@TARGET_mvebu_cortexa53_DEVICE_cznic-mox
  PROVIDES:=u-boot-mox
endef

define Build/Compile
	cd $(PKG_BUILD_DIR); make CROSS_COMPILE=$(TARGET_CROSS) a53-firmware.bin
endef

define Package/mox-uboot/install
	$(INSTALL_DIR) $(1)/usr/share/mox
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/a53-firmware.bin $(1)/usr/share/mox/uboot-devel
endef

$(eval $(call BuildPackage,mox-uboot))
