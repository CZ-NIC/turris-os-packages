FORIS_PLUGIN_DIR:=/usr/share/foris/plugins

define Build/Compile/ForisPlugin
	( \
		cd $(PKG_BUILD_DIR) ;\
		foris_compilemessages.sh src \
	)
	( \
		cd $(PKG_BUILD_DIR)/src/static/ ;\
		compass compile \
			-r breakpoint \
			-s compressed \
			-e production \
			--no-line-comments \
			--css-dir css \
			--sass-dir sass \
			--images-dir img \
			--javascripts-dir js \
			--http-path "/" \
	)
endef

# $1 = package name
# $2 = plugin name
# $3 = plugin translation name
define ForisPluginTranslation

 define Package/$(1)-l10n-$(3)
	TITLE:=$(1)-l10n-$(3)
	DEPENDS:=\
		+foris +foris-l10n-$(3)
	MAINTAINER:=Stepan Henek <stepan.henek@nic.cz>
 endef

 define Package/$(1)-l10n-$(3)/install
	$(INSTALL_DIR) $$(1)/$(FORIS_PLUGIN_DIR)/$(2)/locale/$(3)/LC_MESSAGES
	$(CP) \
		$$(PKG_BUILD_DIR)/src/locale/$(3)/LC_MESSAGES/*.mo \
		$$(1)/$(FORIS_PLUGIN_DIR)/$(2)/locale/$(3)/LC_MESSAGES/
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
 define Package/$(1)/install
	$(INSTALL_DIR) $$(1)/$(FORIS_PLUGIN_DIR)/$(2)

	$(CP) \
		$(PKG_BUILD_DIR)/src/* \
		$$(1)/$(FORIS_PLUGIN_DIR)/$(2)/

	$(RM) -r $$(1)/$(FORIS_PLUGIN_DIR)/$(2)/locale
	$(RM) -r $$(1)/$(FORIS_PLUGIN_DIR)/$(2)/static/.sass-cache
	$(RM) -r $$(1)/$(FORIS_PLUGIN_DIR)/$(2)/static/sass
 endef
endef

