REFORIS_TRANSLATIONS:=cs da de el en es fi fo fr hr hu it ja ko lt nb nl pl ro ru sk sv

# $1 = translation name
define ReForisTranslation

 define Package/reforis-l10n-$(1)
   SECTION:=web
   CATEGORY:=Web
   SUBMENU:=reForis
   TITLE:=reforis-l10n-$(1)
   DEPENDS:=+reforis
   MAINTAINER:=CZ.NIC <packaging@turris.cz>
 endef

 define Package/reforis-l10n-$(1)/install
	$$(INSTALL_DIR) $$(1)$$(PYTHON3_PKG_DIR)/reforis/translations/$(1)/LC_MESSAGES
	$$(CP) \
		$$(PKG_BUILD_DIR)/build/lib/reforis/translations/$(1)/LC_MESSAGES/*.mo \
		$$(1)$$(PYTHON3_PKG_DIR)/reforis/translations/$(1)/LC_MESSAGES/
 endef

 define Package/reforis-l10n-$(1)/postrm
#!/bin/sh
[ -n "$$$${IPKG_INSTROOT}" ] || /etc/init.d/lighttpd restart
 endef

 define Package/reforis-l10n-$(1)/postinst
#!/bin/sh
[ -n "$$$${IPKG_INSTROOT}" ] || /etc/init.d/lighttpd restart
 endef

 $$(eval $$(call BuildPackage,reforis-l10n-$(1)))
endef
