#
## Copyright (C) 2016 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=rescue-mode-omnia
PKG_VERSION:=4
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Michal Hrusecky <michal.hrusecky@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+rainbow-omnia +mtd +btrfs-progs @TARGET_mvebu_Turris-Omnia @!ALL @!PACKAGE_oneshot @!PACKAGE_procd +schnapps
endef

define Package/$(PKG_NAME)/conffiles
endef

define Build/Compile
	echo Building rescue mode
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/bin
	$(INSTALL_DIR) $(1)/sbin
	$(INSTALL_DIR) $(1)/etc

	$(INSTALL_DIR) $(1)/proc
	$(INSTALL_DIR) $(1)/dev
	$(INSTALL_DIR) $(1)/sys
	$(INSTALL_DIR) $(1)/mnt
	$(INSTALL_DIR) $(1)/root

	$(INSTALL_BIN) ./files/rescue.sh 	$(1)/bin/rescue.sh
	$(INSTALL_BIN) ./files/init.sh 		$(1)/sbin/init
	$(INSTALL_BIN) ./files/passwd 		$(1)/etc/passwd
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
