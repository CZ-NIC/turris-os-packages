define Package/python-sqlite3
$(call Package/python/Default)
  TITLE:=Python sqlite3 module
  DEPENDS+=python +libsqlite3
endef

define PyPackage/python-sqlite3/filespec
+|/usr/lib/python$(PYTHON_VERSION)/lib-dynload/_sqlite3.so
+|/usr/lib/python$(PYTHON_VERSION)/sqlite3
endef

$(eval $(call PyPackage,python-sqlite3))
$(eval $(call BuildPackage,python-sqlite3))
