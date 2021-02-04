#
# Copyright (C) 2020-2021 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=reforis-remote-wifi-settings-plugin
PKG_VERSION:=0.2.1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/reforis/reforis-remote-wifi-settings
PKG_MIRROR_HASH:=322fb6c661e35123e5878d0f5f98a232914f5759a25670b1eca8fba5487bd007
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

define Package/reforis-remote-wifi-settings-plugin
  SECTION:=web
  CATEGORY:=Web
  SUBMENU:=reForis
  TITLE:=reForis Remote Wi-Fi Settings plugin
  URL:=https://gitlab.nic.cz/turris/reforis/reforis-remote-wifi-settings
  DEPENDS:=\
    +reforis \
    +reforis-remote-devices-plugin \
    +foris-controller-subordinates-module
  VARIANT:=python3
endef

define Package/reforis-remote-wifi-settings-plugin/description
  reForis Remote Wi-Fi Settings Plugin
endef

REFORIS_TRANSLATIONS:=cs

$(eval $(call ReForisPlugin,reforis-remote-wifi-settings-plugin,reforis_remote_wifi_settings))
# call BuildPackage <= assures OWR build system that this is package
