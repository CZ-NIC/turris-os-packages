#
# Copyright (C) 2020-2021 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=reforis-remote-devices-plugin
PKG_VERSION:=1.4.1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/reforis/reforis-remote-devices
PKG_MIRROR_HASH:=496b08aa88fc3b45da11665e33f7bcad95e343b603db7abeb88bc16d4e6f60a0
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

define Package/reforis-remote-devices-plugin
  SECTION:=web
  CATEGORY:=Web
  SUBMENU:=reForis
  TITLE:=reForis Remote Devices plugin
  URL:=https://gitlab.nic.cz/turris/reforis/reforis-remote-devices
  DEPENDS:= \
    +reforis \
    +foris-controller-subordinates-module
  VARIANT:=python3
endef

define Package/reforis-remote-devices-plugin/description
  reForis Remote Devices plugin
endef

REFORIS_TRANSLATIONS:=cs

$(eval $(call ReForisPlugin,reforis-remote-devices-plugin,reforis_remote_devices))
# call BuildPackage <= assures OWR build system that this is package
