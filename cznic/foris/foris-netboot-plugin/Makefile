#
# Copyright (C) 2019 CZ.NIC z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-netboot-plugin
PKG_VERSION:=0.3
PKG_RELEASE:=1
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/foris-netboot-plugin.git
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
		+foris +foris-controller-netboot-module
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef

define Package/$(PKG_NAME)/description
 Foris plugin for managing netboot devices
endef

# Package install definition
$(eval $(call ForisPlugin,$(PKG_NAME),netboot))

# Translation definitions
FORIS_TRANSLATIONS:=
$(foreach trans,$(FORIS_TRANSLATIONS),$(eval $(call ForisPluginTranslation,$(PKG_NAME),netboot,$(trans))))

$(eval $(call BuildPackage,$(PKG_NAME)))
$(foreach trans,$(FORIS_TRANSLATIONS),$(eval $(call BuildPackage,$(PKG_NAME)-l10n-$(trans))))
