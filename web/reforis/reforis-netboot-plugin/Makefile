#
# Copyright (C) 2020-2021 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=reforis-netboot-plugin
PKG_VERSION:=0.4.0
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/reforis/reforis-netboot
PKG_MIRROR_HASH:=8ee66013173b85a2fd48b80d7ce776f189cd0105e76c4b983779bb0ebc166f43
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

define Package/reforis-netboot-plugin
  SECTION:=web
  CATEGORY:=Web
  SUBMENU:=reForis
  TITLE:=reForis Netboot plugin
  URL:=https://gitlab.nic.cz/turris/reforis/reforis-netboot
  DEPENDS:=\
    +reforis \
    +reforis-remote-devices-plugin \
    +foris-controller-netboot-module
  VARIANT:=python3
endef

define Package/reforis-netboot-plugin/description
  reForis Netboot plugin.
endef

REFORIS_TRANSLATIONS:=cs

$(eval $(call ReForisPlugin,reforis-netboot-plugin,reforis_netboot))
# call BuildPackage <= assures OWR build system that this is package
