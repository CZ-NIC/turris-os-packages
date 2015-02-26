define Package/python-dbm
$(call Package/python/Default)
  TITLE:=Python dbm module
  DEPENDS+=python +libdb47
endef

define PyPackage/python-dbm/filespec
+|/usr/lib/python$(PYTHON_VERSION)/lib-dynload/dbm.so
endef

$(eval $(call PyPackage,python-dbm))
$(eval $(call BuildPackage,python-dbm))
