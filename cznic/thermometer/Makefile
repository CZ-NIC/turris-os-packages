#
## Copyright (C) 2014 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=thermometer
PKG_VERSION:=2
PKG_MAINTAINER:=Robin Obůrka <robin.oburka@nic.cz>

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+lm-sensors
endef

define Build/Compile
	true
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/thermometer $(1)/usr/bin/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
