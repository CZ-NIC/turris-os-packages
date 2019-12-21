#
# Copyright (C) 2019 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=reforis-remote-access-plugin
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/reforis/reforis-remote-access
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
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

define Package/$(PKG_NAME)
  TITLE:=$(PKG_NAME)
  URL:=https://gitlab.labs.nic.cz/turris/reforis/reforis-remote-access
  DEPENDS:= \
    +reforis
  VARIANT=python3
endef

define Package/$(PKG_NAME)/description
  reForis Remote Access Plugin.
endef

REFORIS_TRANSLATIONS:=cs

$(eval $(call ReForisPlugin,$(PKG_NAME),reforis_remote_access))
# call BuildPackage <= assures OWR build system that this is package
