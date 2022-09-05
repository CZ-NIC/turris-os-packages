#
## Copyright (C) 2018-2021 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=mox-uboot-uboot
PKG_VERSION:=2022.07
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE:=u-boot-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=https://ftp.denx.de/pub/u-boot/
PKG_HASH:=92b08eb49c24da14c1adbf70a71ae8f37cc53eeb4230e859ad8b6733d13dcf5e

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=README
PKG_BUILD_PARALLEL:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/u-boot-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/mox-uboot-uboot
  TITLE:=U-boot for Turris MOX
  DEPENDS:=@TARGET_mvebu_cortexa53_DEVICE_cznic_turris-mox
endef

define Build/Compile
	$(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR) CROSS_COMPILE=$(TARGET_CROSS) \
		HOSTCFLAGS=-I$(TOPDIR)/staging_dir/host/include/ \
		HOSTLDFLAGS=-L$(TOPDIR)/staging_dir/host/lib/ \
		HOSTLDLIBS=-lpthread \
		turris_mox_defconfig u-boot.bin
endef

define Package/mox-uboot-uboot/install
	$(INSTALL_DIR) $(1)/usr/share/mox
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/u-boot.bin $(1)/usr/share/mox/u-boot.bin
endef

$(eval $(call BuildPackage,mox-uboot-uboot))
