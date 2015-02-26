define Package/python-bsddb
$(call Package/python/Default)
  TITLE:=Python bsddb module
  DEPENDS+=python +libdb47
endef

define PyPackage/python-bsddb/filespec
+|/usr/lib/python$(PYTHON_VERSION)/bsddb
+|/usr/lib/python$(PYTHON_VERSION)/lib-dynload/_bsddb.so
endef

$(eval $(call PyPackage,python-bsddb))
$(eval $(call BuildPackage,python-bsddb))
