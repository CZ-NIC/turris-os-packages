#
## Copyright (C) 2017-2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=switch-branch
PKG_VERSION:=2.6.1
PKG_RELEASE:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/switch-branch
  SECTION:=updater
  CATEGORY:=Turris Updater
  TITLE:=Tool to set updater to follow different rolling branches
  DEPENDS:=+uci +coreutils-sort +opkg +updater-supervisor +curl
endef

define Package/switch-branch/description
  Turris OS is released in various branches (with different guarantees and levels
  of stability). This script allows simple switch between them and also between
  archived versions. You should know that while move to more unstable branches is
  commonly supported the opposite (while allowed by script) might be problematic.
  The same applies to version downgrades.
endef

Build/Compile:=:

define Package/switch-branch/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/switch-branch $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/updater/conf.d
	$(INSTALL_CONF) ./files/updater.lua $(1)/etc/updater/conf.d/switch-branch.lua
endef

define Package/switch-branch/postinst
[ -n "$$IPKG_INSTROOT" ] || switch-branch --verify --force
endef

$(eval $(call BuildPackage,switch-branch))
