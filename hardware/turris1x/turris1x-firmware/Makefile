#
## Copyright (C) 2013-2021 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-1x-firmware
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/turris-1x-firmware
  TITLE:=Firmware for Turris 1.x
  DEPENDS:=@TARGET_mpc85xx_p2020_DEVICE_turris1x
  PROVIDES:=turris-nor-update-firmware
endef

define Package/turris-1x-firmware/description
  Stable firmware for Turris 1.x
endef

Build/Compile:=:

define Package/turris-1x-firmware/install
	$(INSTALL_DIR) $(1)/usr/share/nor-update/
	$(INSTALL_DATA) ./files/* $(1)/usr/share/nor-update/
endef

$(eval $(call BuildPackage,turris-1x-firmware))
