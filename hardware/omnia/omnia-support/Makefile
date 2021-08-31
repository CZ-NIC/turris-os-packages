include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=omnia-support
PKG_VERSION:=3.4
PKG_RELEASE:=2

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

PKG_BUILD_DIR:=$(KERNEL_BUILD_DIR)/packages
PKG_BUILD_DEPENDS:=linux

include $(INCLUDE_DIR)/package.mk

define Package/omnia-generic-support
  TITLE:=Turris Omnia essential generic support
  VERSION:=$(LINUX_VERSION)-$(LINUX_RELEASE)-$(LINUX_VERMAGIC)
  RELEASE:=$(PKG_VERSION)-$(PKG_RELEASE)
  DEPENDS:=@TARGET_mvebu_cortexa9_DEVICE_cznic_turris-omnia
endef

define Package/omnia-generic-support/description
  Contains generic supporting files for Turris Omnia.
endef

define Package/omnia-support
  TITLE:=Turris Omnia essential support
  DEPENDS:=+omnia-generic-support @TARGET_mvebu_cortexa9_DEVICE_cznic_turris-omnia
endef

define Package/omnia-support/description
  Contains supporting files for Turris Omnia.
endef

define Package/omnia-cti-support
  TITLE:=Turris Omnia CTI support
  DEPENDS:=omnia-generic-support @TARGET_mvebu_cortexa9_DEVICE_cznic_turris-omnia
  PROVIDES:=omnia-support
  CONFLICTS:=omnia-support
endef

define Package/omnia-cti-support/description
  Contains supporting files for Turris Omnia that is part of CTI project.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

Build/Configure:=

define Build/Compile
	sed -e 's|@CONTRACT@|cti|' files/contract-boot.txt | cat - files/boot.txt > "$(PKG_BUILD_DIR)"/boot-cti.txt
	mkimage -T script -C none -n boot -d "$(PKG_BUILD_DIR)"/boot-cti.txt "$(PKG_BUILD_DIR)"/boot-cti.scr
	mkimage -T script -C none -n boot -d files/boot.txt "$(PKG_BUILD_DIR)"/boot.scr
	$(KERNEL_MAKE) zImage dtbs
endef

define Package/omnia-generic-support/install
	$(INSTALL_DIR) $(1)/boot
	$(INSTALL_DATA) $(LINUX_DIR)/arch/$(LINUX_KARCH)/boot/dts/armada-385-turris-omnia-*.dtb "$(1)"/boot
	ln -s boot/boot.scr "$(1)"/boot.scr
endef

define Package/omnia-support/install
	$(INSTALL_DIR) $(1)/boot
	$(INSTALL_DATA) "$(PKG_BUILD_DIR)"/boot.scr "$(1)"/boot/boot.scr
endef

define Package/omnia-cti-support/install
	$(INSTALL_DIR) $(1)/boot
	$(INSTALL_DATA) "$(PKG_BUILD_DIR)"/boot-cti.scr "$(1)"/boot/boot.scr
endef

define Package/omnia-generic-support/postinst
#!/bin/sh
# Link default Omnia dtb unless there is existing link
DTB="$$IPKG_INSTROOT/boot/dtb"
[ -L "$$DTB" ] || ln -sf armada-385-turris-omnia-phy.dtb "$$DTB"
endef

$(eval $(call BuildPackage,omnia-support))
$(eval $(call BuildPackage,omnia-cti-support))
$(eval $(call BuildPackage,omnia-generic-support))
