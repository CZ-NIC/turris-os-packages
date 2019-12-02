#
# Copyright (C) 2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=lxc-hotplug
PKG_VERSION:=0.1
PKG_RELEASE:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/lxc-hotplug
  SECTION:=net
  CATEGORY:=Network
  TITLE:=LXC hotplug
  DEPENDS:=+netifd
endef

define Package/lxc-hotplug/description
  Hotplug script for OpenVPN.
endef

Build/Compile:=:

define Package/lxc-hotplug/install
	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface/
	$(INSTALL_BIN) ./files/lxc.hotplug $(1)/etc/hotplug.d/iface/43-lxc
endef

$(eval $(call BuildPackage,lxc-hotplug))
