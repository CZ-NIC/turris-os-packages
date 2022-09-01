#
## Copyright (C) 2018-2021 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=mox-uboot
PKG_VERSION:=2021-04-rc1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/mox-boot-builder.git
PKG_MIRROR_HASH:=960e37c522a48d994b4ee99a2f039ccd3dc26fda1e17027929c90bab344844f1
PKG_SOURCE_VERSION:=b8928b294a863f2c698c4b230e598f984828a2ad

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=README
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/mox-uboot
  TITLE:=U-boot for Turris MOX
  DEPENDS:=@TARGET_mvebu_cortexa53_DEVICE_cznic-mox
  PROVIDES:=u-boot-mox
endef

define Build/Compile
	$(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR) CROSS_COMPILE=$(TARGET_CROSS) a53-firmware.bin
endef

define Package/mox-uboot/install
	$(INSTALL_DIR) $(1)/usr/share/mox
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/a53-firmware.bin $(1)/usr/share/mox/uboot-devel
endef

$(eval $(call BuildPackage,mox-uboot))
