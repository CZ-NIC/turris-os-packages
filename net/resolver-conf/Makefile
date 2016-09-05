#
# Copyright (C) 2016 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=resolver-conf
PKG_VERSION:=0.0.1
PKG_RELEASE:=4

PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_MAINTAINER:=Jan Pavlinec <jan.pavlinec@nic.cz>
PKG_LICENSE:=GPL-3.0

PKG_INSTALL:=0

include $(INCLUDE_DIR)/package.mk

define Package/resolver-conf
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=IP Addresses and Names
	TITLE:=Resolver configuration
endef

define Package/$(PKG_NAME)/description
  Configuration for knot-resolver and unbound.
endef

define Package/$(PKG_NAME)/conffiles
/etc/config/resolver
endef

define Build/Compile
endef

define Build/Install
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DIR) $(1)/etc/resolver
ifeq ($(CONFIG_TARGET_mvebu_Turris-Omnia),y)
	$(INSTALL_CONF) ./files/resolver-omnia-config $(1)/etc/config/resolver
else
	$(INSTALL_CONF) ./files/resolver-turris-config $(1)/etc/config/resolver
endif
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/resolver-init $(1)/etc/init.d/resolver
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
# check if we are on real system
if [ -z "$$IPKG_INSTROOT" ]; then
if [ ! -f /etc/resolver/converted ]; then
/etc/init.d/resolver convert
touch /etc/resolver/converted
fi
/etc/init.d/resolver enable
fi
exit 0
endef

$(eval $(call BuildPackage,resolver-conf))

