# $1 = package name
# $2 = plugin name
# $3 = plugin translation name
define ForisPluginTranslation

 define Package/$(1)-l10n-$(3)
	TITLE:=$(1)-l10n-$(3)
	DEPENDS:=\
		+foris +foris-l10n-$(3)
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
 endef

 define Package/$(1)-l10n-$(3)/install
	$(INSTALL_DIR) $$(1)$(PYTHON3_PKG_DIR)/foris_plugins/$(2)/locale/$(3)/LC_MESSAGES

	$(CP) \
		$$(PKG_BUILD_DIR)/foris_plugins/$(2)/locale/$(3)/LC_MESSAGES/*.mo \
		$$(1)$(PYTHON3_PKG_DIR)/foris_plugins/$(2)/locale/$(3)/LC_MESSAGES/
 endef

 define Package/$(1)-l10n-$(3)/postrm
#!/bin/sh
set -x
[ -n "$$$${IPKG_INSTROOT}" ] || /etc/init.d/lighttpd restart
 endef

 define Package/$(1)-l10n-$(3)/postinst
#!/bin/sh
set -x
[ -n "$$$${IPKG_INSTROOT}" ] || /etc/init.d/lighttpd restart
 endef
endef

# $1 = package name
# $2 = plugin name
define ForisPlugin

 define Build/Compile
	$(call Build/Compile/Py3Mod,,install --prefix=/usr --root="$(PKG_INSTALL_DIR)")
 endef

 define Package/$(1)/install

	$(INSTALL_DIR) $$(1)$(PYTHON3_PKG_DIR)

	$(CP) \
		$(PKG_INSTALL_DIR)$(PYTHON3_PKG_DIR)/* \
		$$(1)$(PYTHON3_PKG_DIR)/

	$(RM) -r $$(1)$(PYTHON3_PKG_DIR)/foris_plugins/*/locale/
	$(RM) -r $$(1)$(PYTHON3_PKG_DIR)/foris_plugins/__init__.py

 endef

 define Package/$(1)/postrm
#!/bin/sh
set -x
[ -n "$$$${IPKG_INSTROOT}" ] || /etc/init.d/lighttpd restart
 endef

 define Package/$(1)/postinst
#!/bin/sh
set -x
[ -n "$$$${IPKG_INSTROOT}" ] || /etc/init.d/lighttpd restart
 endef


endef

