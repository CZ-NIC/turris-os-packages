define Package/python-gdbm
$(call Package/python/Default)
  TITLE:=Python gdbm module
  DEPENDS+=python +libgdbm
endef

define PyPackage/python-gdbm/filespec
+|/usr/lib/python$(PYTHON_VERSION)/lib-dynload/gdbm.so
endef

$(eval $(call PyPackage,python-gdbm))
$(eval $(call BuildPackage,python-gdbm))
