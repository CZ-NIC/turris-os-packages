#
# Copyright (C) 2009-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=schnapps
PKG_VERSION:=0.8
PKG_RELEASE:=1
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/misc.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=fcb4ff883d39f78c92d5d373240e54d53df3a962
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_MAINTAINER:=Michal Hrusecky <Michal.Hrusecky@nic.cz>
PKG_LICENSE:=GPL-2.0

include $(INCLUDE_DIR)/package.mk

define Package/schnapps
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Filesystem
  DEPENDS:=+btrfs-progs @TARGET_mvebu_Turris-Omnia
  TITLE:=Btrfs snapshots management tool
endef

define Package/schnapps/description
 Schnapps is a simple tool to make snapshot management easy. It has plenty of
 assumptions hardcoded and it is quite slow, but it has almost no dependencies
 and it is simple.
endef

define Package/schnapps/conffiles
/etc/config/schnapps
/etc/cron.d/schnapps
endef

define Build/Compile
	true
endef

define Package/schnapps/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/schnapps/schnapps.sh $(1)/usr/bin/schnapps
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/schnapps/schnapps $(1)/etc/config
	$(INSTALL_DIR) $(1)/etc/updater/hook_preupdate
	$(INSTALL_BIN) ./files/updater_hook.sh $(1)/etc/updater/hook_preupdate/05_schnapps.sh
	$(INSTALL_DIR) $(1)/etc/updater/hook_postupdate
	cat ./files/updater_hook.sh | sed 's|pre|post|g' > $(1)/etc/updater/hook_postupdate/05_schnapps.sh
	$(INSTALL_DIR) $(1)/etc/cron.d
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/schnapps/schnapps.cron $(1)/etc/cron.d/schnapps
endef

$(eval $(call BuildPackage,schnapps))
