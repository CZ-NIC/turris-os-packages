include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=omnia-support
PKG_VERSION:=3.3
PKG_RELEASE:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

PKG_BUILD_DIR:=$(KERNEL_BUILD_DIR)/packages
PKG_BUILD_DEPENDS:=linux

include $(INCLUDE_DIR)/package.mk

define Package/omnia-support
  TITLE:=Turris Omnia essential support
  VERSION:=$(LINUX_VERSION)-$(LINUX_RELEASE)-$(LINUX_VERMAGIC)
  DEPENDS:=@TARGET_mvebu_cortexa9_DEVICE_cznic_turris-omnia \
	  +mtd
endef

define Package/omnia-support/description
  Contains supporting files for Turris Omnia.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

Build/Configure:=

define Build/Compile
	$(KERNEL_MAKE) zImage dtbs
endef

define Package/omnia-support/install
	$(INSTALL_DIR) $(1)/boot
	$(INSTALL_DATA) $(LINUX_DIR)/arch/$(LINUX_KARCH)/boot/dts/armada-385-turris-omnia-*.dtb "$(1)"/boot
	mkimage -T script -C none -n boot -d files/boot.txt "$(1)"/boot/boot.scr
	ln -s boot/boot.scr "$(1)"/boot.scr
	$(INSTALL_DIR) $(1)/usr/sbin
endef

define Package/omnia-support/postinst
#!/bin/sh
# Link default Omnia dtb unless there is existing link
DTB="$$IPKG_INSTROOT/boot/dtb"
[ -L "$$DTB" ] || ln -sf armada-385-turris-omnia-phy.dtb "$$DTB"
endef

$(eval $(call BuildPackage,omnia-support))
