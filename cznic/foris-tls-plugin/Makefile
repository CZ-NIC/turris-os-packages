#
# Copyright (C) 2015 CZ.NIC z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-tls-plugin
PKG_VERSION:=10
PKG_RELEASE:=1
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/foris-tls-plugin.git
PKG_SOURCE_VERSION:=package-v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILE:=LICENSE

PKG_BUILD_DEPENDS:=foris/host

include $(INCLUDE_DIR)/package.mk
include ../foris/files/foris-translations.mk
include ../foris/files/foris-plugin.mk


define Package/foris-tls-plugin
	TITLE:=foris-tls-plugin
	DEPENDS:=\
		+foris +nuci-tls
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef

define Package/foris-tls-plugin/description
 Foris plugin providing frontend for NUCI TLS plugin.
endef

define Build/Compile
	$(call Build/Compile/ForisPlugin)
endef

define Package/foris-tls-plugin/postinst
#!/bin/sh
set -x
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/lighttpd restart
}
endef

define Package/$(PKG_NAME)/postrm
#!/bin/sh
set -x
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/lighttpd restart
}
endef

# Package install definition
$(eval $(call ForisPlugin,$(PKG_NAME),tls))

# Translation definitions
FORIS_TRANSLATIONS:=cs de sk pl fr ru lt
$(foreach trans,$(FORIS_TRANSLATIONS),$(eval $(call ForisPluginTranslation,$(PKG_NAME),tls,$(trans))))

$(eval $(call BuildPackage,$(PKG_NAME)))
$(foreach trans,$(FORIS_TRANSLATIONS),$(eval $(call BuildPackage,$(PKG_NAME)-l10n-$(trans))))
