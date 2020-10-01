#
## Copyright (C) 2019-2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=mox-support
PKG_VERSION:=2.2.0
PKG_RELEASE:=1
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/mox-generic-support
  TITLE:=Generic MOX support package
  DEPENDS:=@TARGET_mvebu_cortexa53_DEVICE_cznic-mox \
    +mtd +kmod-gpio-button-hotplug +mox-dtb
endef

define Package/mox-support
  TITLE:=MOX support package
  DEPENDS:=@TARGET_mvebu_cortexa53_DEVICE_cznic-mox +mox-generic-support
endef

define Package/shield-support
  TITLE:=Shield support package
  DEPENDS:=@TARGET_mvebu_cortexa53_DEVICE_cznic-mox +mox-generic-support \
	  +pkglists
  PROVIDES:=mox-support
  CONFLICTS:=mox-support
endef

define Package/mox-generic-support/description
 Contains generic supporting files for Turris MOX.
endef

define Package/mox-support/description
 Contains supporting files for Turris MOX.
endef

define Package/shield-support/description
 Contains supporting files for Turris Shield.
endef

Build/Compile:=:

define Package/mox-generic-support/install
	$(INSTALL_DIR) $(1)/sbin
	$(INSTALL_BIN) ./files/nor-update $(1)/sbin
	$(INSTALL_DIR) $(1)/usr/share/mox
	$(INSTALL_DATA) ./files/secure-firmware.bin $(1)/usr/share/mox/secure-firmware
	$(INSTALL_DATA) ./files/dtb $(1)/usr/share/mox/dtb
	$(INSTALL_DATA) ./files/rescue $(1)/usr/share/mox/rescue
	$(INSTALL_DATA) ./files/uboot $(1)/usr/share/mox/uboot
	$(INSTALL_DIR) $(1)/etc/hotplug.d/button
	$(INSTALL_DATA) ./files/reset_btn $(1)/etc/hotplug.d/button/mox_reset
	echo '/dev/mtd2 0 0x00010000' > $(1)/etc/fw_env.config
endef

define Package/mox-support/install
	$(INSTALL_DIR) $(1)/boot
	mkimage -T script -C none -n boot -d files/boot.txt "$(1)"/boot/boot.scr
	ln -s boot/boot-ext4.scr "$(1)"/boot.scr
	ln -s boot.scr "$(1)"/boot/boot-ext4.scr
	ln -s boot.scr "$(1)"/boot/boot-btrfs.scr
	$(INSTALL_DIR) $(1)/usr/share/mox
	$(INSTALL_BIN) ./files/mox_autosetup $(1)/usr/share/mox
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/init $(1)/etc/init.d/mox_autosetup
	$(INSTALL_DIR) $(1)/lib/firmware/mrvl/
	$(INSTALL_DATA) ./files/sdsd8997_combo_v4.bin $(1)/lib/firmware/mrvl
	ln -s sdsd8997_combo_v4.bin $(1)/lib/firmware/mrvl/sd8997_uapsta.bin
endef

define Package/shield-support/install
	$(INSTALL_DIR) $(1)/boot
	sed 's|@CONTRACT@|shield|' files/contract-boot.txt | cat - files/boot.txt > $(PKG_BUILD_DIR)/boot.txt
	mkimage -T script -C none -n boot -d $(PKG_BUILD_DIR)/boot.txt "$(1)"/boot/boot.scr
	ln -s boot.scr "$(1)"/boot/boot-btrfs.scr
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/run_nor_update $(1)/etc/uci-defaults/00_nor-update
	$(INSTALL_BIN) ./files/enable_sentinel $(1)/etc/uci-defaults/10_sentinel-enable
	$(INSTALL_BIN) ./files/enable_updater $(1)/etc/uci-defaults/10_updater-enable
	$(INSTALL_DIR) $(1)/etc/lighttpd/conf.d
	$(INSTALL_DATA) ./files/lighttpd-reforis-only.conf $(1)/etc/lighttpd/conf.d/reforis-redirect.conf
endef

$(eval $(call BuildPackage,mox-generic-support))
$(eval $(call BuildPackage,mox-support))
$(eval $(call BuildPackage,shield-support))
