#
## Copyright (C) 2016 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=userlists
PKG_VERSION:=8
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/userlists
	TITLE:=Userlists for the updater
endef

define Build/Compile
	true
endef

define Package/userlists/install
	$(INSTALL_DIR) $(1)/usr/share/updater/
	$(INSTALL_DATA) ./files/definitions $(1)/usr/share/updater/definitions
ifeq ($(CONFIG_TARGET_mpc85xx_p2020_nor_TURRISNOR)$(CONFIG_TARGET_mpc85xx_p2020_nand_TURRISNAND),y)
	sed -i "/^\['lxc'\]/,/},/d" $(1)/usr/share/updater/definitions
endif
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
