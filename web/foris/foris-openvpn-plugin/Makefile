#
# Copyright (C) 2018-2020 CZ.NIC z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-openvpn-plugin
PKG_VERSION:=16.7
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/foris/foris-openvpn-plugin.git
PKG_MIRROR_HASH:=2a3de648cacfccd9a8a59fa6498c86c0d260d72f401ed76d8c96fee95cbef2ee
PKG_SOURCE_VERSION:=package-v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

HOST_PYTHON3_PACKAGE_BUILD_DEPENDS:=libsass==0.14.5
PKG_BUILD_DEPENDS:=foris-plugins-distutils/host

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk
include ../foris/files/foris-translations.mk
include ../foris/files/foris-plugin.mk

define Package/foris-openvpn-plugin
  SECTION:=web
  CATEGORY:=Web
  SUBMENU:=Foris
  TITLE:=Foris OpenVPN plugin
  DEPENDS:= \
    +foris +foris-controller-openvpn-module
  VARIANT:=python3
endef

define Package/foris-openvpn-plugin/description
  Foris plugin for OpenVPN server configuration.
endef

FORIS_TRANSLATIONS:=cs de sk pl fr ru hu it nb

$(eval $(call ForisPlugin,foris-openvpn-plugin,openvpn))
# call BuildPackage <= assures OWR build system that this is package
