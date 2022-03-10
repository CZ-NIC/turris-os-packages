#
## Copyright (C) 2018-2022 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=turris-diagnostics
PKG_VERSION:=16.0.0
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/diagnostics.git
PKG_MIRROR_HASH:=f2480259ed10954d3961a3bba40eca283bc3ac1be53d9943f4e96f8d7d879988
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

LOCALES:=cs da de el es fi fo fr hr hu it ja ko lt nb_NO nl pl ro ru sk sv
WEB_LOCALES:=cs fr nb_NO ru sk
SNAPSHOTS_LOCALES:=cs ru sk nb_NO

include $(INCLUDE_DIR)/package.mk

define Package/Common
  SECTION:=utils
  CATEGORY:=Utilities
endef

define Package/turris-diagnostics
  $(call Package/Common)
  TITLE:=Turris Diagnostics
  DEPENDS:=+lsblk +hwinfo +socat +crypto-wrapper +gettext-tools +file
endef

define Package/turris-diagnostics-web
  $(call Package/Common)
  TITLE:=Turris Diagnostics Web
  DEPENDS:=+turris-diagnostics +turris-bootstrap-theme +lighttpd-mod-fastcgi +lighttpd-mod-alias +lighttpd-mod-authn_pam +uci
endef

define Package/turris-snapshots-web
  $(call Package/Common)
  TITLE:=Turris Schnapps Web
  DEPENDS:=+schnapps +openssl-util +turris-bootstrap-theme +lighttpd-mod-fastcgi +lighttpd-mod-alias +lighttpd-mod-authn_pam +uci
endef

define Package/turris-diagnostics/description
  Obtains diagnostics which are useful for troubleshooting of turris related
  functionality.
endef

define Package/turris-diagnostics-web/description
  Simple web to obtain diagnostics from.
endef

define Package/turris-snapshots-web/description
  Simple web to manage schnapps's snapshots.
endef

Build/Compile:=:

define Package/turris-diagnostics/install
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) ./files/diagnostics.sh $(1)/usr/bin/turris-diagnostics

	$(INSTALL_DIR) $(1)/usr/share/diagnostics/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/diagnostics.sh $(1)/usr/share/diagnostics/diagnostics.sh

	$(INSTALL_DIR) $(1)/usr/share/diagnostics/modules
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/modules/module.sh $(1)/usr/share/diagnostics/modules/module.sh
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/modules/*.module $(1)/usr/share/diagnostics/modules/
endef

define Package/turris-diagnostics-web/install
	$(INSTALL_DIR) $(1)/usr/libexec/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/web/diagnostics.sh $(1)/usr/libexec/web-diagnostics.sh

	$(INSTALL_DIR) $(1)/etc/lighttpd/conf.d/
	$(INSTALL_DATA) ./files/lighttpd-diagnostics.conf $(1)/etc/lighttpd/conf.d/80-diagnostics.conf
endef

define Package/turris-snapshots-web/install
	$(INSTALL_DIR) $(1)/usr/libexec/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/web/snapshots.sh $(1)/usr/libexec/web-snapshots.sh

	$(INSTALL_DIR) $(1)/etc/lighttpd/conf.d/
	$(INSTALL_DATA) ./files/lighttpd-snapshots.conf $(1)/etc/lighttpd/conf.d/80-snapshots.conf
endef

define Package/turris-diagnostics-web/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || /etc/init.d/lighttpd restart
endef

define Package/turris-snapshots-web/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || /etc/init.d/lighttpd restart
endef


# $(1): name of the package
# $(2): translation name
define TRANSLATION

define Package/$(1)-l10n-$(2)
  TITLE:=Translation for package $(1): $(2)
  DEPENDS:=+$(1)
endef

define Package/$(1)-l10n-$(2)/install
	$(MAKE) -C $(PKG_BUILD_DIR) DESTDIR="$$(1)" install-$(1)-$(2)
endef

$$(eval $$(call BuildPackage,$(1)-l10n-$(2)))

endef

$(eval $(call BuildPackage,turris-diagnostics))
$(foreach LANG,$(LOCALES),$(eval $(call TRANSLATION,turris-diagnostics,$(LANG))))
$(eval $(call BuildPackage,turris-diagnostics-web))
$(foreach LANG,$(WEB_LOCALES),$(eval $(call TRANSLATION,turris-diagnostics-web,$(LANG))))
$(eval $(call BuildPackage,turris-snapshots-web))
$(foreach LANG,$(SNAPSHOTS_LOCALES),$(eval $(call TRANSLATION,turris-snapshots-web,$(LANG))))
