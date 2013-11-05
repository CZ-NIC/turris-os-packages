#
## Copyright (C) 2013 CZ.NIC z.s.p.o. <martin.strbacka@nic.cz>
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=rescue-mode
PKG_VERSION:=1
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Martin Strbacka <martin.strbacka@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
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
	$(INSTALL_BIN) ./files/etc/rc.d/S00boot $(1)/etc/rc.d/S00boot
	$(INSTALL_BIN) ./files/etc/init.d/rcS $(1)/etc/init.d/rcS
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
