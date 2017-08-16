#
# Copyright (C) 2017 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-jsonschema
PKG_VERSION:=2.6.0
PKG_RELEASE:=1

PKG_SOURCE:=jsonschema-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://files.pythonhosted.org/packages/source/j/jsonschema/
PKG_MD5SUM:=50c6b69a373a8b55ff1e0ec6e78f13f4

PKG_BUILD_DIR:=$(BUILD_DIR)/jsonschema-$(PKG_VERSION)
HOST_BUILD_DIR:=$(BUILD_DIR_HOST)/jsonschema-$(PKG_VERSION)

HOST_BUILD_DEPENDS:=python/host python-functools32/host
PKG_BUILD_DEPENDS:=python

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk
$(call include_mk, python-package.mk)
$(call include_mk, python-host.mk)

define Package/$(PKG_NAME)
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	TITLE:=python-jsonschema
	URL:=https://python-jsonschema.readthedocs.io/en/latest/
	DEPENDS:=+python-light +python-functools32
	MAINTAINER:=Stepan Henek <stepan.henek@nic.cz>
endef

define Package/$(PKG_NAME)/description
	jsonschema is an implementation of JSON Schema for Python (supporting 2.7+ including Python 3).
endef

define Build/Compile
	$(RM) -r $(PKG_BUILD_DIR)/jsonschema/tests/*
	touch $(PKG_BUILD_DIR)/jsonschema/tests/__init__.py
	$(call Build/Compile/PyMod,., \
		install --prefix="/usr" --root="$(PKG_INSTALL_DIR)" \
	)
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)/
	$(CP) \
		$(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* \
		$(1)$(PYTHON_PKG_DIR)/usr/lib/python2.7/site-packages/
endef


define Host/Compile
	#$(call Build/Compile/HostPyMod,,build)
endef

define Host/Install
	$(call Build/Compile/HostPyMod,,install --prefix="" --root="$(STAGING_DIR)/host")
endef

$(eval $(call HostBuild))

$(eval $(call PyPackage,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_NAME)))
