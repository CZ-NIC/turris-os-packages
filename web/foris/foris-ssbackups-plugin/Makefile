#
# Copyright (C) 2018-2019 CZ.NIC z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-ssbackups-plugin
PKG_VERSION:=8.4
PKG_RELEASE:=4

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/foris/foris-ssbackups-plugin.git
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

define Package/foris-ssbackups-plugin
  TITLE:=Foris ssbackups plugin
  DEPENDS:= \
    +foris \
    +foris-controller-ssbackups-module \
    +foris-data_collect-plugin
  VARIANT:=python3
endef

define Package/foris-ssbackups-plugin/description
  Foris plugin for ssbackups.
endef

FORIS_TRANSLATIONS:=cs de fr hu pl ru sk nb

$(eval $(call ForisPlugin,foris-ssbackups-plugin,ssbackups))
# call BuildPackage <= assures OWR build system that this is package
