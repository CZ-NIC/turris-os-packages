#
# Copyright (C) 2020-2021 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=reforis-netmetr-plugin
PKG_VERSION:=0.2.2
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/reforis/reforis-netmetr
PKG_MIRROR_HASH:=6c0fee4bba2b0422e6cbc3157b2511159ee261beab98226a4f5880b8548ffe81
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

define Package/reforis-netmetr-plugin
  SECTION:=web
  CATEGORY:=Web
  SUBMENU:=reForis
  TITLE:=reForis NetMetr plugin
  URL:=https://gitlab.labs.nic.cz/turris/reforis/reforis-netmetr
  DEPENDS:=\
    +reforis \
    +foris-controller-netmetr-module
  VARIANT:=python3
endef

define Package/reforis-netmetr-plugin/description
  ReForis NetMetr Plugin
endef

REFORIS_TRANSLATIONS:=cs

$(eval $(call ReForisPlugin,reforis-netmetr-plugin,reforis_netmetr))
# call BuildPackage <= assures OWR build system that this is package
