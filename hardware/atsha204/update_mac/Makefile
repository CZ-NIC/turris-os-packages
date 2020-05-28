#
## Copyright (C) 2013-2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=update_mac
PKG_VERSION:=2
PKG_RELEASE:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/update_mac
  TITLE:=Update MAC
  DEPENDS:=+libatsha204
endef

Build/Compile:=:

define Package/update_mac/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/update_mac $(1)/etc/init.d/update_mac
endef

$(eval $(call BuildPackage,update_mac))
