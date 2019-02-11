#
## Copyright (C) 2014 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=thermometer
PKG_VERSION:=3
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
ifeq ($(CONFIG_TARGET_mpc85xx_p2020_nor_TURRISNOR)$(CONFIG_TARGET_mpc85xx_p2020_TURRIS)$(CONFIG_TARGET_mpc85xx_p2020_nand_TURRISNAND),y)
	$(INSTALL_BIN) ./files/thermometer.turris $(1)/usr/bin/thermometer
else ifeq ($(CONFIG_TARGET_mvebu_Turris-Omnia),y)
	$(INSTALL_BIN) ./files/thermometer.omnia $(1)/usr/bin/thermometer
else
	$(INSTALL_BIN) ./files/thermometer.fake $(1)/usr/bin/thermometer
endif
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
