#
## Copyright (C) 2016-2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=rescue-mode-omnia
PKG_VERSION:=4.1
PKG_RELEASE:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-2.0-or-later

include $(INCLUDE_DIR)/package.mk

define Package/rescue-mode-omnia
  TITLE:=rescue-mode-omnia
  DEPENDS:=+btrfs-progs +mtd +schnapps +turris-rainbow
  DEPENDS+=@TARGET_mvebu_Turris-Omnia @!ALL @!PACKAGE_oneshot @!PACKAGE_procd
endef

define Build/Compile
	echo Building rescue mode
endef

define Package/rescue-mode-omnia/install
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

$(eval $(call BuildPackage,rescue-mode-omnia))
