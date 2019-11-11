#
# Copyright (C) 2017-2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=turris1x-btrfs
PKG_VERSION:=2.0
PKG_RELEASE:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-2.0

include $(INCLUDE_DIR)/package.mk

define Package/Common
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Filesystem
  DEPENDS:=@TARGET_mpc85xx
endef

define Package/turris1x-btrfs
  $(call Package/Common)
  DEPENDS:=+btrfs-progs +uboot-envtools +fdisk +dosfstools +schnapps
  TITLE:=Btrfs support for Turris 1.x routers
endef

define Package/turris1x-btrfs-migrate
  $(call Package/Common)
  DEPENDS:=+turris1x-btrfs-support
  TITLE:=Btrfs migration tool for Turris 1.x routers
endef

define Package/turris1x-btrfs/description
  Support package for Turris 1.x routers running from SD card.
endef

define Package/turris1x-btrfs-migrate/description
  This tool will allow you to plug SD card into your Turris 1.x, format it to Btrfs
  and use it for your root filesystem.
endef

Build/Compile:=

define Package/turris1x-btrfs/install
	$(INSTALL_DIR) $(1)/etc/schnapps/rollback.d
	$(INSTALL_BIN) ./files/kernel-rollback $(1)/etc/schnapps/rollback.d/kernel-rollback
	$(INSTALL_DIR) $(1)/etc/updater/hook_postupdate/
	$(INSTALL_BIN) ./files/kernel-install $(1)/etc/updater/hook_postupdate/10_kernel-install
endef

define Package/turris1x-btrfs-migrate/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/btrfs_migrate.sh $(1)/usr/bin/btrfs_migrate
endef

define Package/turris1x-btrfs/prerm
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	grep -q '^/dev/mmcblk0p2 / btrfs' /proc/mounts || create_notification -s error "Odinstalovali jste podporu btrfs, ale stále ji používáte, váš router se pravděpodobně rozbije" "You deinstalled btrfs support but your router is still using it, so it will likelly break."
}
endef

$(eval $(call BuildPackage,turris1x-btrfs))
$(eval $(call BuildPackage,turris1x-btrfs-migrate))
