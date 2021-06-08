#
## Copyright (C) 2021 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-defaults
PKG_VERSION:=0.1.2
PKG_RELEASE:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/turris-defaults
  TITLE:=Turris defaults
endef

define Package/turris-defaults/description
  These are various tweaks to default values injected to system.
endef

define Package/turris-defaults/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults/
	$(INSTALL_BIN) ./files/uci-defaults.sh $(1)/etc/uci-defaults/00-turris-defaults

	$(INSTALL_DIR) $(1)/etc/board.d/
	$(INSTALL_BIN) ./files/board.sh $(1)/etc/board.d/00_turris_defaults

	$(INSTALL_DIR) $(1)/usr/share/turris-defaults/
	$(INSTALL_DATA ./files/defaults/ntpservers $(1)/usr/share/turris-defaults/
endef

Build/Compile:=:

$(eval $(call BuildPackage,turris-defaults))
