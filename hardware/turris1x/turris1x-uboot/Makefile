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
PKG_RELEASE:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/turris1x-uboot
  TITLE:=Turris 1.x U-boot
  DEPENDS:=@TARGET_mpc85xx_p2020_DEVICE_turris1x
  PROVIDES:=u-boot-turris1x
endef

define Package/turris1x-uboot/description
  New development u-boot version for Turris 1.x
endef

Build/Compile:=:

define Package/turris1x-uboot/install
	$(INSTALL_DIR) $(1)/usr/share/turris1x
	$(INSTALL_BIN) ./files/u-boot-nor.bin $(1)/usr/share/turris1x/
endef

$(eval $(call BuildPackage,turris1x-uboot))
