#
## Copyright (C) 2013-2020 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=ip_autoselector
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_LICENSE:=GPL-3.0-or-later
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/ip_autoselector
  TITLE:=Automatically sets non-conflictin prefix on LAN
  DEPENDS:=ethtool
endef

Build/Compile:=:

define Package/ip_autoselector/description
 Contains hotplug script that changes network prefix on LAN network whenever it
 detects conflict with network used on WAN side of the router.
endef

define Package/ip_autoselector/install
	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface
	$(INSTALL_BIN) ./files/ip_autoselector.hotplug $(1)/etc/hotplug.d/iface/10_ip_autoselector
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/ip_autoselector.uci $(1)/etc/uci-defaults/10_ip_autoselector
endef

$(eval $(call BuildPackage,ip_autoselector))
