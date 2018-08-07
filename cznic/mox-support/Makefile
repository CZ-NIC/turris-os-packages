include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=mox-support
PKG_VERSION:=3
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(KERNEL_BUILD_DIR)/packages

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	VERSION:=$(LINUX_VERSION)-$(LINUX_RELEASE)-$(LINUX_VERMAGIC)
	DEPENDS:=@TARGET_mvebu_cortexa53_DEVICE_cznic-mox
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
	for i in "$(1)"/boot/*.dtb; do \
		ln -s `basename $$$$i` `echo $$$$i | sed 's|turris-mox-sd|turris-mox-sd-pci|'`;\
	done
	mkimage -T script -C none -n boot -d files/boot.txt "$(1)"/boot.scr
	$(INSTALL_DIR) $(1)/sbin
	$(INSTALL_BIN) ./files/nor-update $(1)/sbin
	$(INSTALL_DIR) $(1)/usr/share/mox
	$(INSTALL_BIN) ./files/mox_autosetup $(1)/usr/share/mox
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/init $(1)/etc/init.d/mox_autosetup
	$(INSTALL_DATA) ./files/flash-image-1G.bin $(1)/usr/share/mox/uboot-1G
	$(INSTALL_DATA) ./files/flash-image-512M.bin $(1)/usr/share/mox/uboot-512M
	$(INSTALL_DIR) $(1)/lib/firmware/mrvl/
	$(INSTALL_DATA) ./files/sdsd8997_combo_v4.bin $(1)/lib/firmware/mrvl
	ln -s sdsd8997_combo_v4.bin $(1)/lib/firmware/mrvl/sd8997_uapsta.bin
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
