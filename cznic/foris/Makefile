#
# Copyright (C) 2018 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris
PKG_VERSION:=97.13
PKG_RELEASE:=1
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/foris.git
PKG_SOURCE_VERSION:=package-v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
HOST_BUILD_DIR:=$(BUILD_DIR_HOST)/$(PKG_NAME)
PKG_BUILD_DEPENDS:=ruby/host python-slimit/host

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk
include ./files/foris-translations.mk

$(call include_mk, python-package.mk)

define Package/foris-common
	TITLE:=foris-common
	DEPENDS:=\
		+python-light +python-bottle +python-bottle-i18n \
		+python-flup +python-ncclient +python-ubus +nuci +lighttpd +lighttpd-mod-fastcgi \
		+lighttpd-mod-redirect +lighttpd-mod-setenv +lighttpd-mod-alias +foris-ws \
		+foris-client
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef

define Package/foris-common/description
 Common things required for the foris web apps.
endef

# Set "branding" variable to create different builds for different devices
BRAND?=turris
ifeq ($(CONFIG_TARGET_mvebu_Turris-Omnia),y)
BRAND:=omnia
endif

define Build/Prepare
	$(call Build/Prepare/Default)
	$(SED) 's/^__version__ = ".*"/__version__ = "$(PKG_VERSION)"/g' $(PKG_BUILD_DIR)/foris/__init__.py
	$(SED) 's/^DEVICE_CUSTOMIZATION = ".*"/DEVICE_CUSTOMIZATION = "$(BRAND)"/g' $(PKG_BUILD_DIR)/foris/__init__.py
endef

MAKE_FLAGS+=\
	BRAND=$(BRAND)

define Build/Compile
	$(call Build/Compile/Default)
	$(call Build/Compile/PyMod,,install --prefix=/usr --root="$(PKG_INSTALL_DIR)")
endef

define Package/foris-common/conffiles
/etc/config/foris
endef

define Package/foris-common/install
	$(INSTALL_DIR) $(1)/etc/lighttpd/conf.d/
	$(INSTALL_DATA) ./files/foris-root.lighttpd-conf $(1)/etc/lighttpd/conf.d/foris-root.conf

	$(INSTALL_DIR) $(1)/usr/share/foris
	$(INSTALL_BIN) ./files/lighttpd-dynamic-conf $(1)/usr/share/foris/lighttpd-dynamic-conf
	$(INSTALL_BIN) ./files/foris-root-cgi $(1)/usr/share/foris/foris-root-cgi

	$(INSTALL_DIR) $(1)/usr/share/foris/plugins

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/foris.conf $(1)/etc/config/foris

	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/foris.wrapper $(1)/usr/bin/foris

	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)

	$(CP) \
		$(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* \
		$(1)$(PYTHON_PKG_DIR)/
	$(RM) -r $(1)$(PYTHON_PKG_DIR)/foris/locale/
	$(RM) -r $(1)$(PYTHON_PKG_DIR)/foris/langs/??.py
	$(RM) -r $(1)$(PYTHON_PKG_DIR)/foris/wizard
	$(RM) $(1)$(PYTHON_PKG_DIR)/foris/wizard_app.py
	$(RM) -r $(1)$(PYTHON_PKG_DIR)/foris/config
	$(RM) $(1)$(PYTHON_PKG_DIR)/foris/config_app.py

	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)/foris/locale
	touch $(1)$(PYTHON_PKG_DIR)/foris/locale/.keep
endef

define Package/foris-wizard
	TITLE:=foris-wizard
	DEPENDS:=\
		+foris-common
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef

define Package/foris-wizard/description
 Foris wizard webapp.
endef

define Package/foris-config
	TITLE:=foris-config
	DEPENDS:=\
		+foris-common +luci
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef

define Package/foris-wizard/description
 Foris config webapp.
endef

define Package/foris
	TITLE:=foris
	DEPENDS:=\
		+foris-wizard +foris-config
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef

define Package/foris/description
 Web administration interface using nuci for communication.
endef

define Package/foris/install
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)/foris/
	touch $(1)$(PYTHON_PKG_DIR)/foris/.keep
endef

define Package/foris-wizard/install
	$(INSTALL_DIR) $(1)/etc/lighttpd/conf.d/
	$(INSTALL_DATA) ./files/foris-wizard.lighttpd-conf $(1)/etc/lighttpd/conf.d/foris-wizard.conf
	$(INSTALL_DIR) $(1)/usr/share/foris
	$(INSTALL_BIN) ./files/foris-wizard-cgi $(1)/usr/share/foris/foris-wizard-cgi

	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)/foris/wizard
	$(CP) \
		$(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/foris/wizard_app.py \
		$(1)$(PYTHON_PKG_DIR)/foris/
	$(CP) \
		$(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/foris/wizard/* \
		$(1)$(PYTHON_PKG_DIR)/foris/wizard/
endef

define Package/foris-config/install
	$(INSTALL_DIR) $(1)/etc/lighttpd/conf.d/
	$(INSTALL_DATA) ./files/foris-config.lighttpd-conf $(1)/etc/lighttpd/conf.d/foris-config.conf
	$(INSTALL_DIR) $(1)/usr/share/foris
	$(INSTALL_BIN) ./files/foris-config-cgi $(1)/usr/share/foris/foris-config-cgi

	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)/foris/config
	$(CP) \
		$(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/foris/config_app.py \
		$(1)$(PYTHON_PKG_DIR)/foris/
	$(CP) \
		$(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/foris/config/* \
		$(1)$(PYTHON_PKG_DIR)/foris/config/
endef

define Package/foris-common/postinst
#!/bin/sh
set -x
[ -n "$$IPKG_INSTROOT" ] || {
# Cleanup of 1.0
if [ -f /www2/forris.pyc ]; then
	find /www2 -name '*.pyc' -exec rm -f \{\} \;
	rmdir /www2/nuci/modules /www2/nuci /www2/config_handlers /www2/utils /www2 || true
fi
/etc/init.d/lighttpd enable
/etc/init.d/lighttpd restart
}
endef

define Package/foris-common/prerm
#!/bin/sh
set -x
/etc/init.d/lighttpd disable
/etc/init.d/lighttpd stop
endef

define Package/foris-wizard/postinst
#!/bin/sh
set -x
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/lighttpd restart
}
endef

define Package/foris-wizard/postrm
#!/bin/sh
set -x
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/lighttpd restart
}
endef

define Package/foris-config/postinst
#!/bin/sh
set -x
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/lighttpd restart
}
endef

define Package/foris-config/postrm
#!/bin/sh
set -x
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/lighttpd restart
}
endef

define Package/foris-oldconfig
	TITLE:=foris old config
endef

define Package/foris-oldconfig/description
 A hack to go through installation from original Certuma image to something
 far newer without crashing the wizard step. Should not be needed during
 normal operation.
endef

define Package/foris-oldconfig/install
	$(INSTALL_DIR) $(1)/etc/foris
	$(INSTALL_DATA) ./files/foris.conf $(1)/etc/foris/foris-lighttpd-inc.conf
endef

define Build/InstallDev
	$(INSTALL_DIR) $(STAGING_DIR)/mk/
	$(INSTALL_DATA) ./files/foris-translations.mk $(STAGING_DIR)/mk/
	$(INSTALL_DATA) ./files/foris-plugin.mk $(STAGING_DIR)/mk/
endef

define Host/Install
	$(INSTALL_BIN) $(HOST_BUILD_DIR)/tools/compilemessages.sh $(STAGING_DIR_HOST)/bin/foris_compilemessages.sh
endef

define Host/Compile
endef

define Host/Clean
	$(RM) -rf $(STAGING_DIR_HOST)/bin/foris_compilemessages.sh
endef

# $1 = translation name
define ForisTranslation
 define Package/foris-l10n-$(1)
	TITLE:=foris-l10n-$(1)
	DEPENDS:=\
		+foris
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
 endef

 define Package/foris-l10n-$(1)/install
	$(INSTALL_DIR) $$(1)$(PYTHON_PKG_DIR)/foris/locale/$(1)/LC_MESSAGES
	$(CP) \
		$(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/foris/locale/$(1)/LC_MESSAGES/*.mo \
		$$(1)$(PYTHON_PKG_DIR)/foris/locale/$(1)/LC_MESSAGES/
	$(INSTALL_DIR) $$(1)$(PYTHON_PKG_DIR)/foris/langs/
	$(CP) \
		$(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/foris/langs/$(1).py \
		$$(1)$(PYTHON_PKG_DIR)/foris/langs/
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

# Translation definitions
$(foreach trans,$(FORIS_TRANSLATIONS),$(eval $(call ForisTranslation,$(trans))))

$(eval $(call BuildPackage,foris))
$(foreach trans,$(FORIS_TRANSLATIONS),$(eval $(call BuildPackage,foris-l10n-$(trans))))

$(eval $(call PyPackage,foris))
$(eval $(call BuildPackage,foris-common))
$(eval $(call BuildPackage,foris-config))
$(eval $(call BuildPackage,foris-wizard))
$(eval $(call BuildPackage,foris-oldconfig))
$(eval $(call HostBuild))
