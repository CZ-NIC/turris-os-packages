#
## Copyright (C) 2020 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=updater-drivers
PKG_VERSION:=0.1.0
PKG_RELEASE:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/updater-drivers
  SECTION:=updater
  CATEGORY:=Turris Updater
  TITLE:=Automatic drivers installation
  DEPENDS:=+updater-ng
endef

define Package/updater-drivers/install
	$(INSTALL_DIR) $(1)/etc/updater/conf.d
	$(INSTALL_DATA) ./files/updater.lua $(1)/etc/updater/conf.d/drivers.lua
endef

Build/Compile:=:

$(eval $(call BuildPackage,updater-drivers))
