#
# Copyright (C) 2019 CZ.NIC z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-subordinates-plugin
PKG_VERSION:=0.4
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/foris/foris-subordinates-plugin.git
PKG_SOURCE_VERSION:=package-v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(BUILD_VARIANT)-$(PKG_NAME)-$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=LICENSE
PKG_LICENSE_FILES:=GPL-3.0-or-later

HOST_PYTHON3_PACKAGE_BUILD_DEPENDS:=libsass==0.14.5
PKG_BUILD_DEPENDS:=foris-plugins-distutils/host

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk
include ../foris/files/foris-translations.mk
include ../foris/files/foris-plugin.mk

define Package/foris-subordinates-plugin
  TITLE:=Foris Subordinates plugin
  DEPENDS:= \
    +foris +foris-controller-netboot-module +foris-controller-subordinates-module
  VARIANT:=python3
endef

define Package/foris-subordinates-plugin/description
  Foris plugin for managing subordinates devices.
endef

FORIS_TRANSLATIONS:=cs de

$(eval $(call ForisPlugin,foris-subordinates-plugin,subordinates))
# call BuildPackage <= assures OWR build system that this is package
