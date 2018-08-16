#
# Copyright (C) 2018 CZ.NIC z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-storage-plugin
PKG_VERSION:=1
PKG_RELEASE:=16
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/foris-storage-plugin.git
PKG_SOURCE_VERSION:=package-v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILE:=LICENSE

PKG_BUILD_DEPENDS:=python3/host python3-libsass/host python3-setuptools/host foris-plugins-distutils/host

include $(INCLUDE_DIR)/package.mk
include ../foris/files/foris-translations.mk
include ../foris/files/foris-plugin.mk

$(call include_mk, python3-package.mk)

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=\
		+foris +foris-controller-storage-module
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef

define Package/$(PKG_NAME)/description
 Foris plugin for storage management
endef

# Package install definition
$(eval $(call ForisPlugin,$(PKG_NAME),storage))

# Translation definitions
FORIS_TRANSLATIONS:=
$(foreach trans,$(FORIS_TRANSLATIONS),$(eval $(call ForisPluginTranslation,$(PKG_NAME),storage,$(trans))))

$(eval $(call BuildPackage,$(PKG_NAME)))
$(foreach trans,$(FORIS_TRANSLATIONS),$(eval $(call BuildPackage,$(PKG_NAME)-l10n-$(trans))))
