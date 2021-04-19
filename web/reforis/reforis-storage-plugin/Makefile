#
# Copyright (C) 2020-2021 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=reforis-storage-plugin
PKG_VERSION:=0.2.2
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/reforis/reforis-storage
PKG_MIRROR_HASH:=fdf0ce5aafc05c10fb1253cd1c3d903c19bd2d56f5f3a9974ca45614909eb65a
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

HOST_PYTHON3_PACKAGE_BUILD_DEPENDS:=reforis-distutils
PKG_BUILD_DEPENDS:=node/host

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk
include ../reforis/files/reforis-plugin.mk
include ../reforis/files/reforis-translations.mk

define Package/reforis-storage-plugin
  SECTION:=web
  CATEGORY:=Web
  SUBMENU:=reForis
  TITLE:=reForis storage plugin
  URL:=https://gitlab.nic.cz/turris/reforis/reforis-storage
  DEPENDS:=\
    +reforis \
    +foris-controller-storage-module
  VARIANT:=python3
endef

define Package/reforis-storage-plugin/description
  reForis Storage plugin
endef

REFORIS_TRANSLATIONS:=cs

$(eval $(call ReForisPlugin,reforis-storage-plugin,reforis_storage))
# call BuildPackage <= assures OWR build system that this is package
