#
# Copyright (C) 2018-2020 CZ.NIC z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-storage-plugin
PKG_VERSION:=3.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/foris/foris-storage-plugin.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=LICENSE
PKG_LICENSE_FILES:=GPL-3.0-or-later

HOST_PYTHON3_PACKAGE_BUILD_DEPENDS:=libsass==0.14.5
PKG_BUILD_DEPENDS:=foris-plugins-distutils/host

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk
include ../foris/files/foris-translations.mk
include ../foris/files/foris-plugin.mk

define Package/foris-storage-plugin
  TITLE:=Foris Storage plugin
  DEPENDS:=\
    +foris +foris-controller-storage-module
  VARIANT:=python3
endef

define Package/foris-storage-plugin/description
  Foris plugin for storage management.
endef

FORIS_TRANSLATIONS:=cs nb pl sk

$(eval $(call ForisPlugin,foris-storage-plugin,storage))
# call BuildPackage <= assures OWR build system that this is package
