#
## Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=tos3to4
PKG_VERSION:=1.0
PKG_RELEASE:=1
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/tos3to4
  TITLE:=tos3to4
  DEPENDS:=@(TARGET_mvebu_Turris-Omnia||TARGET_mpc85xx_p2020_nand||TARGET_mpc85xx_p2020_nor)
endef

ifdef CONFIG_TARGET_mvebu_Turris-Omnia
BOARD=omnia
else
BOARD=turris1x
endif

define Package/tos3to4/install
	$(INSTALL_DIR) $(1)/etc/updater/conf.d
	$(INSTALL_BIN) ./files/migrate3to4.lua $(1)/etc/updater/conf.d/migrate3to4.lua
	$(INSTALL_BIN) ./files/os-release-$(BOARD) $(1)/etc/os-release
endef

Build/Compile:=:

$(eval $(call BuildPackage,tos3to4))
