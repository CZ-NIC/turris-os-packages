#
# Copyright (C) 2019-2020 CZ.NIC z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-controller-openvpn_client-module
PKG_VERSION:=0.3
PKG_RELEASE:=4

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/foris-controller/foris-controller-openvpn_client-module.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk
include ../foris-controller/files/foris-controller-module.mk

define Package/foris-controller-openvpn_client-module
  SECTION:=web
  CATEGORY:=Web
  SUBMENU:=Foris Controller
  TITLE:=Foris controller OpenVPN client module
  DEPENDS:= \
    +foris-controller \
    +turris-cagen \
    +openvpn-openssl
  VARIANT:=python3
endef

define Package/foris-controller-openvpn_client-module/description
  This is a OpenVPN client module for foris-controller.
endef

define ForisControllerModule/foris-controller-openvpn_client-module/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/uci-defaults/vpn-client-network $(1)/etc/uci-defaults/50_add-vpn-client-network
endef

$(eval $(call ForisControllerModule,foris-controller-openvpn_client-module))
# call BuildPackage <= assures OWR build system that this is package
