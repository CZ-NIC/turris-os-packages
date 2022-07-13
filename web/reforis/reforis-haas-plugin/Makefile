#
# Copyright (C) 2020-2021 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=reforis-haas-plugin
PKG_VERSION:=0.1.3
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/reforis/reforis-haas
PKG_MIRROR_HASH:=c27d45f42744953eb006c0860540ee13fd13698652b7f97ff75e331766ad1273
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

define Package/reforis-haas-plugin
  SECTION:=web
  CATEGORY:=Web
  SUBMENU:=reForis
  TITLE:=reForis HaaS plugin
  URL:=https://gitlab.nic.cz/turris/reforis/reforis-haas
  DEPENDS:=\
    +reforis \
    +reforis-data-collection-plugin \
    +foris-controller-haas-module
  VARIANT:=python3
endef

define Package/reforis-haas-plugin/description
  reForis Honeypot as a Service plugin
endef

REFORIS_TRANSLATIONS:=cs

$(eval $(call ReForisPlugin,reforis-haas-plugin,reforis_haas))
# call BuildPackage <= assures OWR build system that this is package
