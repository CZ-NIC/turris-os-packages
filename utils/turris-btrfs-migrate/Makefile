#
# Copyright (C) 2017 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=turris-btrfs-migrate
PKG_VERSION:=1.3
PKG_RELEASE:=1
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_MAINTAINER:=Michal Hrusecky <Michal.Hrusecky@nic.cz>
PKG_LICENSE:=GPL-2.0

include $(INCLUDE_DIR)/package.mk

define Package/turris-btrfs-migrate
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Filesystem
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
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/btrfs_migrate.sh $(1)/usr/bin/btrfs_migrate
endef

$(eval $(call BuildPackage,turris-btrfs-migrate))
