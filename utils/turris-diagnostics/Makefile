#
## Copyright (C) 2018-2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=turris-diagnostics
PKG_VERSION:=15.0.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/diagnostics.git
PKG_MIRROR_HASH:=7abf1d938530922d8acadc6bcfcde8cf933a668499453b5c3931dbad65438ad9
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

LOCALES:=cs da de el es fi fo fr hr hu it ja ko lt nb nl pl ro ru sk sv

include $(INCLUDE_DIR)/package.mk

define Package/turris-diagnostics
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Turris Diagnostics
  DEPENDS:=+lsblk +socat +crypto-wrapper +gettext-tools
endef

define Package/turris-diagnostics/description
  Obtains diagnostics which are useful for troubleshooting of turris related
  functionality.
endef

Build/Compile:=:

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) ./files/diagnostics.sh $(1)/usr/bin/turris-diagnostics

	$(INSTALL_DIR) $(1)/usr/share/diagnostics/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/diagnostics.sh $(1)/usr/share/diagnostics/diagnostics.sh

	$(INSTALL_DIR) $(1)/usr/share/diagnostics/modules
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/modules/module.sh $(1)/usr/share/diagnostics/modules/module.sh
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/modules/*.module $(1)/usr/share/diagnostics/modules/
endef

define TRANSLATION

define Package/turris-diagnostics-l10n-$(1)
  TITLE:=Translation for package turris-diagnostics: $(1)
  DEPENDS:=+turris-diagnostics
endef

define Package/turris-diagnostics-l10n-$(1)/install
	$(MAKE) -C $(PKG_BUILD_DIR) DESTDIR="$$(1)" install-$(1)
endef

$$(eval $$(call BuildPackage,turris-diagnostics-l10n-$(1)))

endef

$(eval $(call BuildPackage,turris-diagnostics))
$(foreach LANG,$(LOCALES),$(eval $(call TRANSLATION,$(LANG))))
