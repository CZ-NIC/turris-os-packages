include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=mox-support
PKG_VERSION:=19
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(KERNEL_BUILD_DIR)/packages

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	VERSION:=$(LINUX_VERSION)-$(LINUX_RELEASE)-$(LINUX_VERMAGIC)
	DEPENDS:=@TARGET_mvebu_cortexa53_DEVICE_cznic-mox +mtd +kmod-gpio-button-hotplug
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
	$(CP) $(LINUX_DIR)/arch/$(LINUX_KARCH)/boot/dts/marvell/armada-3720-turris-mox.dtb "$(1)"/boot
	mkimage -T script -C none -n boot -d files/boot.txt "$(1)"/boot/boot-ext4.scr
	sed -e 's|rootwait|rootwait rootflags=subvol=@,commit=5|' \
	    -e 's|/boot|/@/boot|g' files/boot.txt > "$(PKG_BUILD_DIR)"/boot-btrfs.txt
	ln -s boot/boot-ext4.scr "$(1)"/boot.scr
	mkimage -T script -C none -n boot -d "$(PKG_BUILD_DIR)"/boot-btrfs.txt "$(1)"/boot/boot-btrfs.scr
	$(INSTALL_DIR) $(1)/sbin
	$(INSTALL_BIN) ./files/nor-update $(1)/sbin
	$(INSTALL_DIR) $(1)/usr/share/mox
	$(INSTALL_BIN) ./files/mox_autosetup $(1)/usr/share/mox
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/init $(1)/etc/init.d/mox_autosetup
	$(INSTALL_DATA) ./files/secure-firmware.bin $(1)/usr/share/mox/secure-firmware
	$(INSTALL_DATA) ./files/dtb $(1)/usr/share/mox/dtb
	$(INSTALL_DATA) ./files/rescue $(1)/usr/share/mox/rescue
	$(INSTALL_DATA) ./files/uboot $(1)/usr/share/mox/uboot
	$(INSTALL_DIR) $(1)/etc/hotplug.d/button
	$(INSTALL_DATA) ./files/reset_btn $(1)/etc/hotplug.d/button/mox_reset
	$(INSTALL_DIR) $(1)/lib/firmware/mrvl/
	$(INSTALL_DATA) ./files/sdsd8997_combo_v4.bin $(1)/lib/firmware/mrvl
	echo '/dev/mtd2 0 0x00010000' > $(1)/etc/fw_env.config
	ln -s sdsd8997_combo_v4.bin $(1)/lib/firmware/mrvl/sd8997_uapsta.bin
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
