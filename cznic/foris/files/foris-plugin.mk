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
define ForisPlugin
 define Package/$(1)/install
	$(INSTALL_DIR) $$(1)/$(FORIS_PLUGIN_DIR)/$(2)

	$(CP) \
		$(PKG_BUILD_DIR)/src/* \
		$$(1)/$(FORIS_PLUGIN_DIR)/$(2)/

	find $$(1) -name "*.po" -delete
	$(RM) -r $$(1)/$(FORIS_PLUGIN_DIR)/$(2)/static/.sass-cache
	$(RM) -r $$(1)/$(FORIS_PLUGIN_DIR)/$(2)/static/sass
 endef
endef

