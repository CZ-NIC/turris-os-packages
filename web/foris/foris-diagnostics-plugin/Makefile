#
# Copyright (C) 2018-2019 CZ.NIC z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-diagnostics-plugin
PKG_VERSION:=12.1
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/foris/foris-diagnostics-plugin.git
PKG_SOURCE_VERSION:=package-v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz


PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

HOST_PYTHON3_PACKAGE_BUILD_DEPENDS:=libsass==0.14.5
PKG_BUILD_DEPENDS:=foris-plugins-distutils/host

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk
include ../foris/files/foris-translations.mk
include ../foris/files/foris-plugin.mk

define Package/foris-diagnostics-plugin
  TITLE:=Foris Diagnostics plugin
  DEPENDS:= \
    +foris +foris-controller-diagnostics-module
  VARIANT:=python3
endef

define Package/foris-diagnostics-plugin/description
  Foris plugin for generating diagnostics.
endef

FORIS_TRANSLATIONS:=cs de sk pl fr ru lt hu it nb

$(eval $(call ForisPlugin,foris-diagnostics-plugin,diagnostics))
# call BuildPackage <= assures OWR build system that this is package