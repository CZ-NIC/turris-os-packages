#
## Copyright (C) 2013-2021 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-mox-firmware
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/turris-mox-firmware
  TITLE:=Firmware for Turris MOX
  DEPENDS:=@TARGET_mvebu_cortexa53_DEVICE_cznic-mox
  PROVIDES:=turris-nor-update-firmware
endef

define Package/turris-mox-firmware/description
  Stable firmware for Turris MOX
endef

define Package/turris-mox-devel-firmware
  TITLE:=Data files for nor-update (development version)
  DEPENDS:=+turris-nor-update +rescue-image +u-boot-mox @TARGET_mvebu_cortexa53_DEVICE_cznic-mox
  PROVIDES:=turris-nor-update-devel-firmware
  VERSION:=0.0
  RELEASE:=1
endef

define Package/turris-mox-devel-firmware/description
  Virtual package to pull in development versions of NOR images (U-Boot and Rescue)
  for Turris MOX
endef

Build/Compile:=:

Package/turris-mox-devel-firmware/install:=:

define Package/turris-mox-firmware/install
	$(INSTALL_DIR) $(1)/usr/share/nor-update/
	$(INSTALL_DATA) ./files/* $(1)/usr/share/nor-update/
endef

$(eval $(call BuildPackage,turris-mox-firmware))
$(eval $(call BuildPackage,turris-mox-devel-firmware))
