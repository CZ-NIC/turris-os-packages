#
## Copyright (C) 2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=sentinel-firewall
PKG_VERSION:=0.1.1
PKG_RELEASE:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/sentinel-firewall
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Sentinel
  TITLE:=Firewall
  DEPENDS:=+firewall
endef

Build/Compile:=:

define Package/sentinel-firewall/install
	$(INSTALL_DIR) $(1)/usr/libexec/sentinel/firewall.d
	$(INSTALL_BIN) ./files/firewall.sh $(1)/usr/libexec/sentinel/
	$(INSTALL_DATA) ./files/common.sh $(1)/usr/libexec/sentinel/firewall.d/
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/uci-defaults $(1)/etc/uci-defaults/99-sentinel-firewall
	$(INSTALL_DIR) $(1)/lib/functions
	$(INSTALL_DATA) ./files/functions.sh $(1)/lib/functions/sentinel-firewall.sh
endef

$(eval $(call BuildPackage,sentinel-firewall))
