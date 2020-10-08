#
# Copyright (C) 2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=reforis-remote-wifi-settings-plugin
PKG_VERSION:=0.2.0
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/reforis/reforis-remote-wifi-settings
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
