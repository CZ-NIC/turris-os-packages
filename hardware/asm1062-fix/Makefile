#
## Copyright (C) 2017-2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=asm1062-fix
PKG_VERSION:=1.1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  TITLE:=fix problem with stability of asm1062
endef

define Package/$(PKG_NAME)/description
  This fixes problems with ASMedia Technology Inc. ASM1062 Serial ATA Controller.
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/init $(1)/etc/init.d/asm1062-fix
endef

Build/Compile:=:

$(eval $(call BuildPackage,$(PKG_NAME)))
