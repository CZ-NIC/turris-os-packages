#
## Copyright (C) 2018-2022 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris1x-uboot
PKG_VERSION:=2022.04
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/u-boot.git
PKG_MIRROR_HASH:=e4543eaa802678e2ac6d79b16eab36b387722ba2ac619284bd91052d30e9a631
PKG_SOURCE_DATE:=2022-08-31
PKG_SOURCE_VERSION:=turris1x-v2022.04

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=README
PKG_BUILD_PARALLEL:=0

include $(INCLUDE_DIR)/package.mk

define Package/turris1x-uboot
  TITLE:=Turris 1.x U-boot
  DEPENDS:=@TARGET_mpc85xx_p2020_DEVICE_turris1x
  PROVIDES:=u-boot-turris1x
endef

define Package/turris1x-uboot-sd
  TITLE:=Turris 1.x U-boot SD
  DEPENDS:=@TARGET_mpc85xx_p2020_DEVICE_turris1x
endef

define Package/turris1x-uboot/description
  NOR U-boot version for Turris 1.x
endef

define Package/turris1x-uboot-nor/description
  SDCard U-boot version for Turris 1.x
endef

define Build/Compile
	$(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR) CROSS_COMPILE=$(TARGET_CROSS) turris_1x_nor_defconfig u-boot-with-dtb.bin
	$(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR) CROSS_COMPILE=$(TARGET_CROSS) turris_1x_sdcard_defconfig u-boot-with-spl.bin
endef

define Package/turris1x-uboot/install
	$(INSTALL_DIR) $(1)/usr/share/turris1x
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/u-boot-with-dtb.bin $(1)/usr/share/turris1x/u-boot-nor.bin
endef

define Package/turris1x-uboot-sd/install
	$(INSTALL_DIR) $(1)/usr/share/turris1x
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/u-boot-with-spl.bin $(1)/usr/share/turris1x/u-boot-sdcard.bin
endef

$(eval $(call BuildPackage,turris1x-uboot))
$(eval $(call BuildPackage,turris1x-uboot-sd))
