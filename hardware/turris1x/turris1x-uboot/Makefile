#
## Copyright (C) 2018-2022 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris1x-uboot
PKG_VERSION:=$(if $(DUMP),x,$(shell sed -ne 's#PKG_VERSION:=##p' $(TOPDIR)/package/boot/uboot-mpc85xx/Makefile))
PKG_RELEASE:=$(AUTORELEASE)

PKG_BUILD_DEPENDS:=uboot-mpc85xx

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=README

include $(INCLUDE_DIR)/package.mk

define Package/turris1x-uboot
  TITLE:=Turris 1.x U-boot
  DEPENDS:=@TARGET_mpc85xx_p2020_DEVICE_cznic_turris1x
  PROVIDES:=u-boot-turris1x
endef

define Package/turris1x-uboot-sd
  TITLE:=Turris 1.x U-boot SD
  DEPENDS:=@TARGET_mpc85xx_p2020_DEVICE_cznic_turris1x
endef

define Package/turris1x-uboot/description
  NOR U-boot version for Turris 1.x
endef

define Package/turris1x-uboot-sd/description
  SDCard U-boot version for Turris 1.x
endef

define Build/Configure
  true
endef

define Build/Compile
  true
endef

define Package/turris1x-uboot/install
	$(INSTALL_DIR) $(1)/usr/share/turris1x
	$(CP) $(STAGING_DIR_IMAGE)/turris1x-nor-u-boot-with-dtb.bin (1)/usr/share/turris1x/u-boot-nor.bin
endef

define Package/turris1x-uboot-sd/install
	$(INSTALL_DIR) $(1)/usr/share/turris1x
	$(CP) $(PKG_BUILD_DIR)/turris1x-sd-u-boot-with-spl.bin $(1)/usr/share/turris1x/u-boot-sdcard.bin
endef

$(eval $(call BuildPackage,turris1x-uboot))
$(eval $(call BuildPackage,turris1x-uboot-sd))
