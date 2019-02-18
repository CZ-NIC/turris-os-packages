#
# Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris
PKG_VERSION:=99.6.1
PKG_RELEASE:=1
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/foris.git
PKG_SOURCE_VERSION:=package-v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(BUILD_VARIANT)-$(PKG_NAME)-$(PKG_VERSION)

PKG_BUILD_DEPENDS:=\
	ruby/host \
	python-libsass/host \
	python3-pytz/host \
	python3-babel/host \
	MarkupSafe/host \
	Jinja2/host

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk
include ./files/foris-translations.mk

PKG_UNPACK:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

define Package/foris
	TITLE:=foris
	DEPENDS:=\
		+python3-light +python3-bottle +python3-bottle-i18n +python3-setuptools \
		+python3-flup +python3-ubus +python3-jinja2 +lighttpd +lighttpd-mod-fastcgi \
		+lighttpd-mod-redirect +lighttpd-mod-setenv +lighttpd-mod-alias +foris-ws \
		+foris-client +luci +fosquitto +python3-paho-mqtt \
		+crypto-wrapper
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
	VARIANT:=python3
endef

define Package/foris/description
 Web administration interface using nuci for communication.
endef

define run_foris_makefile
	$(call Build/Compile/Default)
endef
Hooks/Compile/Pre += run_foris_makefile

define Package/foris/conffiles
/etc/config/foris
endef

define Package/foris/install
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

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/foris.conf $(1)/etc/config/foris

	$(INSTALL_DIR) $(1)$(PYTHON3_PKG_DIR)

	$(CP) \
		$(PKG_INSTALL_DIR)$(PYTHON3_PKG_DIR)/* \
		$(1)$(PYTHON3_PKG_DIR)/
	$(RM) -r $(1)$(PYTHON3_PKG_DIR)/foris/locale/
	$(RM) -rf $(1)$(PYTHON3_PKG_DIR)/foris/langs/??.py
	$(RM) -rf $(1)$(PYTHON3_PKG_DIR)/foris/langs/??.pyc

	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/foris $(1)/usr/bin/foris

	$(INSTALL_DIR) $(1)$(PYTHON3_PKG_DIR)/foris/locale
	touch $(1)$(PYTHON3_PKG_DIR)/foris/locale/.keep
endef

define Package/foris/postinst
#!/bin/sh
set -x
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/lighttpd enable
/etc/init.d/lighttpd restart
}
endef

define Package/foris/prerm
#!/bin/sh
set -x
/etc/init.d/lighttpd restart
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
set -x
[ -n "$$$${IPKG_INSTROOT}" ] || /etc/init.d/lighttpd restart
 endef

 define Package/foris-l10n-$(1)/postinst
#!/bin/sh
set -x
[ -n "$$$${IPKG_INSTROOT}" ] || /etc/init.d/lighttpd restart
 endef

endef

$(eval $(call Py3Package,foris))
$(eval $(call BuildPackage,foris))
$(eval $(call BuildPackage,foris-src))

# Translation definitions
$(foreach trans,$(FORIS_TRANSLATIONS),$(eval $(call ForisTranslation,$(trans))))
$(foreach trans,$(FORIS_TRANSLATIONS),$(eval $(call BuildPackage,foris-l10n-$(trans))))
