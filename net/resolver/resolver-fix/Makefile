#
# Copyright (C) 2020 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=resolver-fix
PKG_VERSION:=0.0.1
PKG_RELEASE:=1

PKG_MAINTAINER:=Jan Pavlinec <jan.pavlinec@nic.cz>
PKG_LICENSE:=GPL-3.0-or-later

PKG_INSTALL:=0

include $(INCLUDE_DIR)/package.mk

define Package/resolver-fix
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  TITLE:=Resolver script to fix older config
endef

define Package/resolver-conf/description
 This script fixes older config options which are no longer supported.
endef

define Build/Compile
endef

define Build/Install
endef

define Package/resolver-fix/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/resolver-fix $(1)/etc/uci-defaults/resolver-fix
	$(INSTALL_DIR) $(1)/etc/resolver
	$(INSTALL_BIN) ./files/dynamic-domain-conv $(1)/etc/resolver/dynamic-domain-conv.sh

endef

define Package/resolver-fix/postinst
#!/bin/sh
# check if we are on real system
if [ -z "$$IPKG_INSTROOT" ]; then
	/etc/uci-defaults/resolver-fix && rm /etc/uci-defaults/resolver-fix
	/etc/resolver/dynamic-domain-conv.sh
fi
endef

$(eval $(call BuildPackage,resolver-fix))
