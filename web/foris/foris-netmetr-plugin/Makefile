#
# Copyright (C) 2018-2020 CZ.NIC z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-netmetr-plugin
PKG_VERSION:=4.6.2
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/foris/foris-netmetr-plugin.git
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

define Package/foris-netmetr-plugin
  SECTION:=web
  CATEGORY:=Web
  SUBMENU:=Foris
  TITLE:=Foris Netmetr plugin
  DEPENDS:= \
    +foris \
    +foris-controller-netmetr-module
  VARIANT:=python3
endef

define Package/foris-netmetr-plugin/description
  Foris plugin for Netmetr.
endef

FORIS_TRANSLATIONS:=cs it de sk ru pl it hu fr nb

$(eval $(call ForisPlugin,foris-netmetr-plugin,netmetr))
# call BuildPackage <= assures OWR build system that this is package
