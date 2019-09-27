#
# Copyright (C) 2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=openvpn-hotplug
PKG_VERSION:=0.1
PKG_RELEASE:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/openvpn-hotplug
  SECTION:=net
  CATEGORY:=Network
  TITLE:=OpenVPN hotplug
  DEPENDS:=+netifd
endef

define Package/openvpn-hotplug/description
  Hotplug script for OpenVPN.
endef

Build/Compile:=:

define Package/openvpn-hotplug/install
	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface/
	$(INSTALL_BIN) ./files/openvpn.hotplug $(1)/etc/hotplug.d/iface/42-openvpn
endef

$(eval $(call BuildPackage,openvpn-hotplug))
