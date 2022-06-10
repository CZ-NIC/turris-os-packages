#
## Copyright (C) 2018-2022 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=omnia-uboot
PKG_VERSION:=2022.07-rc4
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://source.denx.de/u-boot/u-boot.git
PKG_MIRROR_HASH:=3e3c292aa99631ffc0b25f6307fd3f8746955f5ba32092cbd6adf5f7ddda60ab
PKG_SOURCE_DATE:=2022-06-06
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=README

include $(INCLUDE_DIR)/package.mk

define Package/omnia-uboot
  TITLE:=u-boot-omnia
  DEPENDS:=@TARGET_mvebu_cortexa9_DEVICE_cznic_turris-omnia
  PROVIDES:=u-boot-omnia
endef

define Build/Compile
	cd $(PKG_BUILD_DIR); make CROSS_COMPILE=$(TARGET_CROSS) turris_omnia_defconfig
	cd $(PKG_BUILD_DIR); make CROSS_COMPILE=$(TARGET_CROSS) u-boot-spl.kwb
endef

define Package/omnia-uboot/install
	$(INSTALL_DIR) $(1)/usr/share/omnia
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/u-boot-spl.kwb $(1)/usr/share/omnia/uboot-devel
endef

$(eval $(call BuildPackage,omnia-uboot))
