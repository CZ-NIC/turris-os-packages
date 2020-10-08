# $1 = package name
# $2 = plugin name
# $3 = plugin translation name
define ForisPluginTranslation

 define Package/$(1)-l10n-$(3)
    SECTION:=web
    CATEGORY:=Web
    SUBMENU:=Foris
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
[ -n "$$$${IPKG_INSTROOT}" ] || /etc/init.d/lighttpd restart
 endef

 define Package/$(1)-l10n-$(3)/postinst
#!/bin/sh
[ -n "$$$${IPKG_INSTROOT}" ] || /etc/init.d/lighttpd restart
 endef

 $$(eval $$(call BuildPackage,$(1)-l10n-$(3)))
endef

# $1 = package name
# $2 = plugin name
define ForisPlugin

 ifndef ForisPlugin/$(1)/install
  ForisPlugin/$(1)/install:=:
 endif

 define Py3Package/$(1)/filespec
+|$(PYTHON3_PKG_DIR)
-|$(PYTHON3_PKG_DIR)/foris_plugins/__init__.py
-|$(PYTHON3_PKG_DIR)/foris_plugins/*/locale/
 endef

 define Py3Package/$(1)/install
	if [ -d $(PKG_INSTALL_DIR)/usr/bin ]; then \
		$(INSTALL_DIR) $$(1)/usr/bin ; \
		$(CP) $(PKG_INSTALL_DIR)/usr/bin/* $$(1)/usr/bin/ ; \
	fi
	$$(call ForisPlugin/$(1)/install,$$(1))
 endef

 ifndef Package/$(1)/postrm
  define Package/$(1)/postrm
#!/bin/sh
[ -n "$$$${IPKG_INSTROOT}" ] || /etc/init.d/lighttpd restart
  endef
 endif

 ifndef Package/$(1)/postinst
  define Package/$(1)/postinst
#!/bin/sh
[ -n "$$$${IPKG_INSTROOT}" ] || /etc/init.d/lighttpd restart
  endef
 endif

 $$(eval $$(call Py3Package,$(1)))
 $$(eval $$(call BuildPackage,$(1)))
 $$(eval $$(call BuildPackage,$(1)-src))
 $(foreach trans,$(FORIS_TRANSLATIONS),$(call ForisPluginTranslation,$(1),$(2),$(trans)))

endef

