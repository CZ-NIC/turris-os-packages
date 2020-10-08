#
# Copyright (C) 2019-2020 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris
PKG_VERSION:=101.1
PKG_RELEASE:=3

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/foris/foris.git
PKG_SOURCE_VERSION:=package-v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=LICENSE
PKG_LICENSE_FILES:=GPL-3.0-or-later

HOST_PYTHON3_PACKAGE_BUILD_DEPENDS:= \
	pytz==2018.9 \
	Babel==2.6.0 \
	libsass==0.14.5 \
	MarkupSafe==1.1.1 \
	Jinja2==2.10
PKG_BUILD_DEPENDS:= \
	compass/host \
	ruby-breakpoint/host

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk
include ./files/foris-translations.mk

define Package/foris
  SECTION:=web
  CATEGORY:=Web
  SUBMENU:=Foris
  TITLE:=Foris
  DEPENDS:= \
    +python3-light +python3-bottle +python3-bottle-i18n +python3-setuptools \
    +python3-flup +python3-ubus +python3-jinja2 +lighttpd +lighttpd-mod-fastcgi \
    +lighttpd-mod-redirect +lighttpd-mod-setenv +lighttpd-mod-alias +foris-ws \
    +foris-client +luci +fosquitto +python3-paho-mqtt \
    +crypto-wrapper
  VARIANT:=python3
endef

define Package/foris/description
  Turris Web administration interface.
endef

define run_foris_makefile
	$(call Build/Compile/Default)
endef
Hooks/Compile/Pre += run_foris_makefile

define Py3Package/foris/filespec
+|$(PYTHON3_PKG_DIR)
-|$(PYTHON3_PKG_DIR)/foris/locale/*
-|$(PYTHON3_PKG_DIR)/foris/langs/??.py
-|$(PYTHON3_PKG_DIR)/foris/langs/??.pyc
endef

define Py3Package/foris/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin/

	$(INSTALL_DIR) $(1)$(PYTHON3_PKG_DIR)/foris/locale
	touch $(1)$(PYTHON3_PKG_DIR)/foris/locale/.keep

	$(INSTALL_DIR) $(1)/usr/share/turris-webapps
	$(INSTALL_DATA) ./files/00_foris.conf $(1)/usr/share/turris-webapps/
	$(INSTALL_DIR) $(1)/www/webapps-icons
	$(INSTALL_DATA) ./files/foris.jpg $(1)/www/webapps-icons

	$(INSTALL_DIR) $(1)/etc/lighttpd/conf.d/
	$(INSTALL_DATA) ./files/foris-config.lighttpd-conf $(1)/etc/lighttpd/conf.d/foris-config.conf

	$(INSTALL_DIR) $(1)/usr/share/foris
	$(INSTALL_BIN) ./files/lighttpd-dynamic-conf $(1)/usr/share/foris/lighttpd-dynamic-conf
	$(INSTALL_BIN) ./files/foris-config-cgi $(1)/usr/share/foris/foris-config-cgi
	$(SED) 's%/usr/lib/python...%/usr/lib/python$(PYTHON3_VERSION)%g' $(1)/usr/share/foris/lighttpd-dynamic-conf
endef

define Package/foris/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	/etc/init.d/lighttpd enable
	/usr/bin/maintain-lighttpd-restart
}
endef

define Package/foris/prerm
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || /usr/bin/maintain-lighttpd-restart
endef

# $1 = translation name
define ForisTranslation
 define Package/foris-l10n-$(1)
	TITLE:=foris-l10n-$(1)
	DEPENDS:=\
		+foris
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
	VARIANT:=python3
 endef

 define Package/foris-l10n-$(1)/install
	$(INSTALL_DIR) $$(1)$(PYTHON3_PKG_DIR)/foris/locale/$(1)/LC_MESSAGES
	$(CP) \
		$(PKG_INSTALL_DIR)$(PYTHON3_PKG_DIR)/foris/locale/$(1)/LC_MESSAGES/*.mo \
		$$(1)$(PYTHON3_PKG_DIR)/foris/locale/$(1)/LC_MESSAGES/
	$(INSTALL_DIR) $$(1)$(PYTHON3_PKG_DIR)/foris/langs/
	$(CP) \
		$(PKG_INSTALL_DIR)$(PYTHON3_PKG_DIR)/foris/langs/$(1).py* \
		$$(1)$(PYTHON3_PKG_DIR)/foris/langs/
 endef

 define Package/foris-l10n-$(1)/postrm
#!/bin/sh
[ -n "$$$${IPKG_INSTROOT}" ] || /etc/init.d/lighttpd restart
 endef

 define Package/foris-l10n-$(1)/postinst
#!/bin/sh
[ -n "$$$${IPKG_INSTROOT}" ] || /etc/init.d/lighttpd restart
 endef

endef

$(eval $(call Py3Package,foris))
$(eval $(call BuildPackage,foris))
$(eval $(call BuildPackage,foris-src))

# Translation definitions
$(foreach trans,$(FORIS_TRANSLATIONS),$(eval $(call ForisTranslation,$(trans))))
$(foreach trans,$(FORIS_TRANSLATIONS),$(eval $(call BuildPackage,foris-l10n-$(trans))))
