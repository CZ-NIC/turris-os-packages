# $1 = package name

define ForisControllerModule
 define Package/$(1)/install
	$(INSTALL_DIR) $$(1)$(PYTHON_PKG_DIR) $$(1)/usr/bin
	if [ -d $(PKG_INSTALL_DIR)/usr/bin ]; then find $(PKG_INSTALL_DIR)/usr/bin -mindepth 1 -maxdepth 1 -type f -exec $(CP) \{\} $$(1)/usr/bin/ \; ; fi
	find $(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR) -mindepth 1 -maxdepth 1 \( -type f -o -type d \) -exec $(CP) \{\} $$(1)$(PYTHON_PKG_DIR)/ \;
	$(RM) $$(1)/usr/lib/python*/site-packages/foris_controller_modules/__init__.py
	$(RM) $$(1)/usr/lib/python*/site-packages/foris_controller_backends/__init__.py
 endef

 define Package/$(1)/postrm
#!/bin/sh
set -x
[ -n "$$$${IPKG_INSTROOT}" ] || /etc/init.d/foris-controller restart
 endef

 define Package/$(1)/postinst
#!/bin/sh
set -x
[ -n "$$$${IPKG_INSTROOT}" ] || /etc/init.d/foris-controller restart
 endef
endef
