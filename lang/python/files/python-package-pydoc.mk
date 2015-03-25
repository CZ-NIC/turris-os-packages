define Package/python-pydoc
$(call Package/python/Default)
  TITLE:=Python pydoc module
  DEPENDS+=python
endef

define PyPackage/python-pydoc/filespec
+|/usr/lib/python$(PYTHON_VERSION)/pydoc.py
+|/usr/lib/python$(PYTHON_VERSION)/pydoc_data
endef

$(eval $(call PyPackage,python-pydoc))
$(eval $(call BuildPackage,python-pydoc))
