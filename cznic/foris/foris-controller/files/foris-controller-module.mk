# $1 = package name
define ForisControllerModule

 ifndef ForisControllerModule/$(1)/install
  ForisControllerModule/$(1)/install:=:
 endif

 define Py3Package/$(1)/install
	if [ -d $(PKG_INSTALL_DIR)/usr/bin ]; then \
		$(INSTALL_DIR) $$(1)/usr/bin ; \
		$(CP) $(PKG_INSTALL_DIR)/usr/bin/* $$(1)/usr/bin/ ; \
	fi
	$(RM) $$(1)/usr/lib/python$(PYTHON3_VERSION)/site-packages/foris_controller_modules/__init__.py
	$(RM) $$(1)/usr/lib/python$(PYTHON3_VERSION)/site-packages/foris_controller_backends/__init__.py
	$$(call ForisControllerModule/$(1)/install,$$(1))
 endef

 ifndef Package/$(1)/postrm
  define Package/$(1)/postrm
[ -n "$$$${IPKG_INSTROOT}" ] || /etc/init.d/foris-controller restart
  endef
 endif

 ifndef Package/$(1)/postinst
  define Package/$(1)/postinst
[ -n "$$$${IPKG_INSTROOT}" ] || /etc/init.d/foris-controller restart
  endef
 endif

 $$(eval $$(call Py3Package,$(1)))
 $$(eval $$(call BuildPackage,$(1)))
 $$(eval $$(call BuildPackage,$(1)-src))

endef
