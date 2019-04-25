#
## Copyright (C) 2016-2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=pkglists
PKG_VERSION:=1.0.5
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=Packages lists for the updater
endef

define Build/Compile
	true
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/share/updater/
ifeq ($(CONFIG_TARGET_mvebu_cortexa9_DEVICE_turris-omnia)$(CONFIG_TARGET_mpc85xx_p2020_nand)$(CONFIG_TARGET_mpc85xx_p2020_nor)$(CONFIG_TARGET_mpc85xx_p2020_TURRIS),)
	$(INSTALL_DATA) ./files/definitions.json $(1)/usr/share/updater/pkglists.json
else
	$(INSTALL_DATA) ./files/definitions.atsha.json $(1)/usr/share/updater/pkglists.json
endif
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
