#
## Copyright (C) 2019-2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=mox-support
PKG_VERSION:=2.3.0
PKG_RELEASE:=5
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/mox-generic-support
  TITLE:=Generic MOX support package
  DEPENDS:=@TARGET_mvebu_cortexa53_DEVICE_cznic_turris-mox \
    +mtd +kmod-gpio-button-hotplug +mox-dtb
endef

define Package/mox-support
  TITLE:=MOX support package
  DEPENDS:=@TARGET_mvebu_cortexa53_DEVICE_cznic_turris-mox +mox-generic-support
endef

define Package/shield-support
  TITLE:=Shield support package
  DEPENDS:=@TARGET_mvebu_cortexa53_DEVICE_cznic_turris-mox +mox-generic-support \
	  +pkglists +turris-nor-update +turris-mox-firmware
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
	true
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
	$(INSTALL_DIR) $(1)/etc/hotplug.d/button
	$(INSTALL_DATA) ./files/reset_btn $(1)/etc/hotplug.d/button/mox_reset
endef

define Package/shield-support/install
	$(INSTALL_DIR) $(1)/boot
	# Factory reset by default - third mode but counting from 0
	sed -e 's|@CONTRACT@|shield|' -e 's|@RESET@|2|' files/contract-boot.txt | cat - files/boot.txt > $(PKG_BUILD_DIR)/boot.txt
	mkimage -T script -C none -n boot -d $(PKG_BUILD_DIR)/boot.txt "$(1)"/boot/boot.scr
	ln -s boot.scr "$(1)"/boot/boot-btrfs.scr
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/run_nor_update $(1)/etc/uci-defaults/00_nor-update
	$(INSTALL_BIN) ./files/enable_sentinel $(1)/etc/uci-defaults/10_sentinel-enable
	$(INSTALL_BIN) ./files/enable_updater $(1)/etc/uci-defaults/10_updater-enable
	$(INSTALL_DIR) $(1)/etc/lighttpd/conf.d
	$(INSTALL_DATA) ./files/lighttpd-reforis-only.conf $(1)/etc/lighttpd/conf.d/reforis-redirect.conf
	$(INSTALL_DIR) $(1)/etc/hotplug.d/button
	$(INSTALL_DATA) ./files/shield_reset_btn $(1)/etc/hotplug.d/button/mox_reset
endef

define Package/shield-support/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	/usr/sbin/nor-update
}
endef

$(eval $(call BuildPackage,mox-generic-support))
$(eval $(call BuildPackage,mox-support))
$(eval $(call BuildPackage,shield-support))
