include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=mox-support
PKG_VERSION:=1
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(KERNEL_BUILD_DIR)/packages

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	VERSION:=$(LINUX_VERSION)-$(LINUX_RELEASE)-$(LINUX_VERMAGIC)
endef

define Package/$(PKG_NAME)/description
 Contains supporting files for Turris MOX.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
	$(KERNEL_MAKE) Image dtbs
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/boot
	for d in $(LINUX_DIR)/arch/$(LINUX_KARCH)/boot/dts/marvell/*-turris-mox-sd*.dtb; do \
		$(CP) $$$$d "$(1)"/boot; \
	done
	ln -s armada-3720-turris-mox-sd.dtb "$(1)"/boot/armada-3720-turris-mox-sd-.dtb
	ln -s armada-3720-turris-mox-sd.dtb "$(1)"/boot/armada-3720-turris-mox-sd-pci.dtb
	ln -s armada-3720-turris-mox-sd-sfp.dtb "$(1)"/boot/armada-3720-turris-mox-sd-sfp-pci.dtb
	ln -s armada-3720-turris-mox-sd-sfp.dtb "$(1)"/boot/armada-3720-turris-mox-sd-pci-sfp.dtb
	mkimage -T script -C none -n boot -d files/boot.txt "$(1)"/boot.scr
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
