#
## Copyright (C) 2018-2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=mox-uboot
PKG_VERSION:=2020-07-rc1
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/mox-boot-builder.git
PKG_SOURCE_VERSION:=24de5b79eb0aeecaa611ced7513de8d87f0a1bcc

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
	cd $(PKG_BUILD_DIR); make CROSS_COMPILE=$(TARGET_CROSS) u-boot.bin
endef

define Package/mox-uboot/install
	$(INSTALL_DIR) $(1)/usr/share/mox
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/u-boot.bin $(1)/usr/share/mox/uboot-devel
endef

$(eval $(call BuildPackage,mox-uboot))
