#
## Copyright (C) 2022 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=mox-a53-firmware
PKG_VERSION:=2.7
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE:=trusted-firmware-a-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/snapshot
PKG_HASH:=53422dc649153838e03820330ba17cb10afe3e330ecde0db11e4d5f1361a33e6

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=docs/license.rst
PKG_BUILD_PARALLEL:=1

export GCC_HONOUR_COPTS=s

PKG_BUILD_DIR:=$(BUILD_DIR)/trusted-firmware-a-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=uboot-mvebu

include $(INCLUDE_DIR)/package.mk

define Package/mox-a53-firmware
  TITLE:=Trusted firmware for Turris MOX
  DEPENDS:=@TARGET_mvebu_cortexa53_DEVICE_cznic_turris-mox
  PROVIDES:=u-boot-mox
endef

define Build/Compile
	$(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR) \
		CROSS_COMPILE=$(TARGET_CROSS) \
		USE_COHERENT_MEM=0 \
		PLAT=a3700 \
		CM3_SYSTEM_RESET=1 \
		FIP_ALIGN=0x100 \
		BL33=$(STAGING_DIR_IMAGE)/mox-u-boot.bin \
		OPENSSL_DIR=$(STAGING_DIR_HOST) \
		mrvl_bootimage
	cp $(PKG_BUILD_DIR)/build/a3700/release/boot-image.bin $(PKG_BUILD_DIR)/a53-firmware.bin
	cd $(PKG_BUILD_DIR); od -v -tu8 -An -j 131184 -N 8 $(PKG_BUILD_DIR)/a53-firmware.bin | LC_ALL=C awk '{ for (i = 0; i < 64; i += 8) printf "%c", and(rshift(1310720-$$$$1, i), 255) }' | dd of=$(PKG_BUILD_DIR)/a53-firmware.bin bs=1 seek=131192 count=8 conv=notrunc 2>/dev/null
endef

define Package/mox-a53-firmware/install
	$(INSTALL_DIR) $(1)/usr/share/mox
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/a53-firmware.bin $(1)/usr/share/mox/uboot-devel
endef

$(eval $(call BuildPackage,mox-a53-firmware))
