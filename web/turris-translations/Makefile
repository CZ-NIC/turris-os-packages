#
## Copyright (C) 2018-2022 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-translations
PKG_VERSION:=1.6.0
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/turris-translations.git
PKG_MIRROR_HASH:=a843ca2a1ca4b43e065848aa7d92e6b2865e42fe0c000b0bdf5e49267f5b499c
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

$(eval $(call TRANSLATION,pkglists,cs da de el es fi fo fr hr hu it ja ko lt nb_NO nl pl ro ru sk sv))
$(eval $(call TRANSLATION,user-notify,cs da de el es fi fo fr hr hu it ja ko lt nb_NO nl pl ro ru sk sv tr))
