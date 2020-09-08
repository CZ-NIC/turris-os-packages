#
## Copyright (C) 2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=mox-dtb
PKG_VERSION:=$(LINUX_VERSION)-$(LINUX_RELEASE)-$(LINUX_VERMAGIC)
PKG_RELEASE:=1
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(KERNEL_BUILD_DIR)/packages
PKG_BUILD_DEPENDS:=linux

include $(INCLUDE_DIR)/package.mk

define Package/mox-dtb
  TITLE:=Device tree for Turris MOX
  DEPENDS:=@TARGET_mvebu_cortexa53_DEVICE_cznic-mox
endef

define Package/mox-dtb/description
 Contains device tree for Turris MOX.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Compile
	$(KERNEL_MAKE) Image dtbs
endef

define Package/mox-dtb/install
	$(INSTALL_DIR) $(1)/boot
	$(CP) $(LINUX_DIR)/arch/$(LINUX_KARCH)/boot/dts/marvell/armada-3720-turris-mox.dtb "$(1)"/boot
endef

$(eval $(call BuildPackage,mox-dtb))
