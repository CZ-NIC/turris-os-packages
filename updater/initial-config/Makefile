#
## Copyright (C) 2020 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=initial-config
PKG_VERSION:=0.2.3
PKG_RELEASE:=$(AUTORELEASE)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/initial-config
  SECTION:=updater
  CATEGORY:=Turris Updater
  TITLE:=Initial config for initial boot
  DEPENDS:=+jshn +python3-pbkdf2 \
    +kmod-fs-btrfs +kmod-fs-ext4 +kmod-fs-xfs +kmod-fs-vfat +kmod-fs-exfat
endef

define Package/initial-config/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/initial-config $(1)/etc/uci-defaults/99-initial-config
endef

Build/Compile:=:

$(eval $(call BuildPackage,initial-config))
