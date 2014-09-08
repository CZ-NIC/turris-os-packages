#
## Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=rescue-mode
PKG_VERSION:=2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Martin Strbacka <martin.strbacka@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+rainbow
endef

define Package/$(PKG_NAME)/conffiles
/etc/init.d/
/etc/rc.d/
endef

define Build/Compile
	echo Building rescue mode
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/rc.d
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/usr/share/udhcpc
	$(INSTALL_DIR) $(1)/usr/bin

	$(INSTALL_DIR) $(1)/proc
	$(INSTALL_DIR) $(1)/dev
	$(INSTALL_DIR) $(1)/dev/pts
	$(INSTALL_DIR) $(1)/sys
	$(INSTALL_DIR) $(1)/mnt
	$(INSTALL_DIR) $(1)/root

	$(INSTALL_BIN) ./files/etc/rc.d/S00boot $(1)/etc/rc.d/S00boot
	$(INSTALL_BIN) ./files/etc/rc.d/S01flash $(1)/etc/rc.d/S01flash
	$(INSTALL_BIN) ./files/etc/rc.d/K99umount $(1)/etc/rc.d/K99umount
	$(INSTALL_BIN) ./files/etc/init.d/rcS $(1)/etc/init.d/rcS
	$(INSTALL_BIN) ./files/etc/passwd $(1)/etc/passwd
	$(INSTALL_BIN) ./files/usr/share/udhcpc/default.script $(1)/usr/share/udhcpc/default.script
	$(INSTALL_BIN) ./files/usr/bin/flash_medkit $(1)/usr/bin/flash_medkit
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
