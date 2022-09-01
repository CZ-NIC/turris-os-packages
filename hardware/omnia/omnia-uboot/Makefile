#
## Copyright (C) 2018-2022 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=omnia-uboot
PKG_VERSION:=2022.10-rc3
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://source.denx.de/u-boot/u-boot.git
PKG_MIRROR_HASH:=64c9ef3f6a9807609fa8ee31153147fc6b514067d831caaa13ad7729608c283b
PKG_SOURCE_DATE:=2022-08-23
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=README
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/omnia-uboot
  TITLE:=u-boot-omnia
  DEPENDS:=@TARGET_mvebu_cortexa9_DEVICE_cznic_turris-omnia
  PROVIDES:=u-boot-omnia
endef

define Build/Compile
	$(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR) CROSS_COMPILE=$(TARGET_CROSS) turris_omnia_defconfig
	$(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR) CROSS_COMPILE=$(TARGET_CROSS) u-boot-spl.kwb
endef

define Package/omnia-uboot/install
	$(INSTALL_DIR) $(1)/usr/share/omnia
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/u-boot-spl.kwb $(1)/usr/share/omnia/uboot-devel
endef

$(eval $(call BuildPackage,omnia-uboot))
