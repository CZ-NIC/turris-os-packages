#
## Copyright (C) 2018-2020 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=u-boot-mox
PKG_VERSION:=2018-11-rc1
PKG_RELEASE:=9

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/mox-boot-builder.git
PKG_SOURCE_VERSION:=5d6e645f5b00afa47d330017add5898056f9996b

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=README

include $(INCLUDE_DIR)/package.mk

define Package/u-boot-mox
  TITLE:=u-boot-mox
  DEPENDS:=@TARGET_mvebu_cortexa53_DEVICE_cznic-mox
endef

define Build/Compile
	cd $(PKG_BUILD_DIR); make CROSS_COMPILE=$(TARGET_CROSS) u-boot.bin
endef

define Package/u-boot-mox/install
	$(INSTALL_DIR) $(1)/usr/share/mox
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/u-boot.bin $(1)/usr/share/mox/uboot-devel
endef

$(eval $(call BuildPackage,u-boot-mox))
