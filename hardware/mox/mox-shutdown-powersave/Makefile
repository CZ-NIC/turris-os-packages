#
## Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=mox-shutdown-powersave
PKG_VERSION:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  TITLE:=Initfile to enter powersave mode just before shutdown
  DEPENDS:=@TARGET_mvebu_cortexa53_DEVICE_cznic-mox
endef

define Package/$(PKG_NAME)/description
  This fixes problem with reboot and shutdown on Turris MOX. The possible problem
  is with high power requirements on core regulator. Lowering CPU speed just
  before shutdown decreases load and makes appropriate reboot reliable.
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/init $(1)/etc/init.d/mox-shutdown-powersave
endef

Build/Compile:=:

$(eval $(call BuildPackage,$(PKG_NAME)))
