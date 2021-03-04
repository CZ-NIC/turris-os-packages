#
# Copyright (C) 2020-2021 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=reforis-haas-plugin
PKG_VERSION:=0.1.1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/reforis/reforis-haas
PKG_MIRROR_HASH:=f9217cdb79bfa798e5c8379eb0834db39cb22899b8fade7036ea3ad257358d43
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_DEPENDS:=\
	node/host \
	reforis-distutils/host \

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
