#
# Copyright (C) 2018-2019 CZ.NIC z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-data_collect-plugin
PKG_VERSION:=1.4
PKG_RELEASE:=3

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/foris/foris-data_collect-plugin.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

HOST_PYTHON3_PACKAGE_BUILD_DEPENDS:=libsass==0.14.5
PKG_BUILD_DEPENDS:=foris-plugins-distutils/host

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk
include ../foris/files/foris-translations.mk
include ../foris/files/foris-plugin.mk

define Package/foris-data_collect-plugin
  TITLE:=Foris Data Collect plugin
  DEPENDS:= \
    +foris +foris-controller-data_collect-module
  VARIANT:=python3
endef

define Package/foris-data_collect-plugin/description
  Foris plugin for Data Collection system.
endef

FORIS_TRANSLATIONS:=cs da fr de hu it lt nb pl ru sk

$(eval $(call ForisPlugin,foris-data_collect-plugin,data_collect))
# call BuildPackage <= assures OWR build system that this is package
