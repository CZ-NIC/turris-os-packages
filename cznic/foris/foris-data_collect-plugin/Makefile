#
# Copyright (C) 2018 CZ.NIC z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-data_collect-plugin
PKG_VERSION:=1.3
PKG_RELEASE:=1
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/foris-data_collect-plugin.git
PKG_SOURCE_VERSION:=package-v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILE:=LICENSE

PKG_BUILD_DIR:=$(BUILD_DIR)/$(BUILD_VARIANT)-$(PKG_NAME)-$(PKG_VERSION)

PKG_BUILD_DEPENDS:=python3/host python-libsass/host python3-setuptools/host foris-plugins-distutils/host

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk
include ../foris/files/foris-translations.mk
include ../foris/files/foris-plugin.mk

PKG_UNPACK:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=\
		+foris +foris-controller-data_collect-module
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
	VARIANT:=python3
endef

define Package/$(PKG_NAME)/description
 Foris plugin for data collect program
endef

# Package install definition
$(eval $(call ForisPlugin,$(PKG_NAME),data_collect))

# Translation definitions
FORIS_TRANSLATIONS:=cs da fr de hu it lt nb pl ru sk
$(foreach trans,$(FORIS_TRANSLATIONS),$(eval $(call ForisPluginTranslation,$(PKG_NAME),data_collect,$(trans))))

$(eval $(call BuildPackage,$(PKG_NAME)))
$(foreach trans,$(FORIS_TRANSLATIONS),$(eval $(call BuildPackage,$(PKG_NAME)-l10n-$(trans))))
