include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=turris1x-support
PKG_VERSION:=1.3
PKG_RELEASE:=4

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

PKG_BUILD_DIR:=$(KERNEL_BUILD_DIR)/packages
PKG_BUILD_DEPENDS:=linux

include $(INCLUDE_DIR)/package.mk

define Package/turris1x-support
  TITLE:=Turris 1.x hardware support files
  VERSION:=$(LINUX_VERSION)-$(LINUX_RELEASE)-$(LINUX_VERMAGIC)
  DEPENDS:=@TARGET_mpc85xx_p2020_DEVICE_turris1x
endef

define Package/turris1x-support/description
  Contains hardware supporting files for Turris 1.X.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

Build/Configure:=:

define Build/Compile
	$(KERNEL_MAKE) zImage turris1x.dtb
endef

define Package/turris1x-support/install
	$(INSTALL_DIR) $(1)/boot
	$(INSTALL_DATA) $(LINUX_DIR)/arch/$(LINUX_KARCH)/boot/turris1x.dtb "$(1)"/boot/
	ln -sf turris1x.dtb "$(1)"/boot/fdt
	mkimage -T script -C none -n boot -d files/boot.txt "$(1)"/boot/boot.scr
endef

$(eval $(call BuildPackage,turris1x-support))
