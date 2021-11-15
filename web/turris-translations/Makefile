#
## Copyright (C) 2018-2020 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-translations
PKG_VERSION:=1.5.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/turris-translations.git
PKG_MIRROR_HASH:=131774d9920af3c3b4030abc7ece33864bd13798696b254a56364efe795c50d5
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DEPENDS:=gettext-full

include $(INCLUDE_DIR)/package.mk

Build/Compile:=:

# This is meta package for translations for multiple other smaller packages.
# So this generates multiple other packages. Call and evaluate following define
# where first argument has to be a name of package and template at the same time
# and second argument has to be a supported language codes.

define TRANSLATION_LANG

define Package/$(1)-l10n-$(2)
  TITLE:=Translation for package $(1): $(2)
  DEPENDS:=+$(1)
endef

define Package/$(1)-l10n-$(2)/install
	$(MAKE) -C $(PKG_BUILD_DIR) DESTDIR="$$(1)" install-$(1)-$(2)
endef

$$(eval $$(call BuildPackage,$(1)-l10n-$(2)))
endef

define TRANSLATION
$$(foreach LANG,$(2),$$(eval $$(call TRANSLATION_LANG,$(1),$$(LANG))))
endef

$(eval $(call TRANSLATION,pkglists,cs da de el es fi fo fr hr hu it ja ko lt nb nl pl ro ru sk sv))
$(eval $(call TRANSLATION,user-notify,cs da de el es fi fo fr hr hu it ja ko lt nb nl pl ro ru sk sv))
