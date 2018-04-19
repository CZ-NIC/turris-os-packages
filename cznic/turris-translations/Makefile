#
## Copyright (C) 2018 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-translations
PKG_VERSION:=1.0.4
PKG_RELEASE:=1
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/turris-translations.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
PKG_BUILD_DEPENDS:=gettext

include $(INCLUDE_DIR)/package.mk

define Build/Compile
	true
endef

# This is meta package for translations for multiple other smaller packages.
# So this generates multiple other packages. Call and evaluate following define
# where first argument has to be a name of package and template at the same time
# and second argument has to be a supported language codes.

define TRANSLATION_LANG

define Package/$(1)-l10n-$(2)
	TITLE:=Translation for package $(1): $(2)
	DEPENDS:=+$(1) +gettext
endef

define Package/$(1)-l10n-$(2)/install
	$(MAKE) -C $(PKG_BUILD_DIR) DESTDIR="$$(1)" install-$(1)-$(2)
endef

$$(eval $$(call BuildPackage,$(1)-l10n-$(2)))
endef

define TRANSLATION
$$(foreach LANG,$(2),$$(eval $$(call TRANSLATION_LANG,$(1),$$(LANG))))
endef

$(eval $(call TRANSLATION,userlists,cs de))
