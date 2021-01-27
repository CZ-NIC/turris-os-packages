#
# Copyright (C) 2017 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=turris-btrfs-migrate
PKG_VERSION:=1.5
PKG_RELEASE:=5
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_MAINTAINER:=Michal Hrusecky <Michal.Hrusecky@nic.cz>
PKG_LICENSE:=GPL-2.0

include $(INCLUDE_DIR)/package.mk

define Package/turris-btrfs-migrate
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Filesystem
  DEPENDS:=+turris-btrfs
  TITLE:=Btrfs migration tool for old Turris routers
endef

define Package/turris-btrfs-migrate/description
 Empty wrapper to provide easy migration.
endef


define Package/turris-btrfs
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Filesystem
	PROVIDES:=turris-btrfs-migrate
  DEPENDS:=+btrfs-progs +uboot-envtools +fdisk +mkdosfs +schnapps @TARGET_mpc85xx_p2020_nand
  TITLE:=Btrfs migration tool for old Turris routers
endef

define Package/turris-btrfs-migrate/description
 This tool will allow you to plug SD card into your Turris, format it to Btrfs
 and use it for your root filesystem.
endef

define Build/Compile
	true
endef

define Package/turris-btrfs-migrate/install
	true
endef

define Package/turris-btrfs/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/btrfs_migrate.sh $(1)/usr/bin/btrfs_migrate
	$(INSTALL_DIR) $(1)/etc/schnapps/rollback.d
	$(INSTALL_BIN) ./files/kernel-rollback $(1)/etc/schnapps/rollback.d/kernel-rollback
	$(INSTALL_DIR) $(1)/etc/updater/hook_postupdate/
	$(INSTALL_BIN) ./files/kernel-install $(1)/etc/updater/hook_postupdate/10_kernel-install
endef

define Package/turris-btrfs-migrate/postinst
[ -n "$$IPKG_INSTROOT" ] || {
	sed -i 's|Install("turris-btrfs-migrate")|Install("turris-btrfs")|' /etc/updater/conf.d/opkg-auto.lua
}
endef

define Package/turris-btrfs/prerm
[ -n "$$IPKG_INSTROOT" ] || {
	[ -z "`cat /proc/mounts | grep '^/dev/mmcblk0p2 / btrfs'`" ] || create_notification -s error "Odinstalovali jste podporu btrfs, ale stále ji používáte, váš router se pravděpodobně rozbije" "You deinstalled btrfs support but your router is still using it, so it will likelly break."
}
endef

$(eval $(call BuildPackage,turris-btrfs))
$(eval $(call BuildPackage,turris-btrfs-migrate))
