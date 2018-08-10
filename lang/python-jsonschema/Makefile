#
# Copyright (C) 2018 CZ.NIC z.s.p.o. (http://www.nic.cz/)
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

PKG_BUILD_DEPENDS:=python python3 python-setuptools python3-setuptools

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)
$(call include_mk, python3-package.mk)

define Package/Common
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	URL:=https://python-jsonschema.readthedocs.io/en/latest/
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef

define Package/python-jsonschema
	$(call Package/Common)
	TITLE:=python-jsonschema
	DEPENDS:=+python-light +python-functools32
endef

define Package/python3-jsonschema
	$(call Package/Common)
	TITLE:=python3-jsonschema
	DEPENDS:=+python3-light
endef

define Package/$(PKG_NAME)/description
	jsonschema is an implementation of JSON Schema for Python (supporting 2.7+ including Python 3).
endef

define Build/Compile
	$(RM) -r $(PKG_BUILD_DIR)/jsonschema/tests/*
	touch $(PKG_BUILD_DIR)/jsonschema/tests/__init__.py
	$(call Build/Compile/PyMod,., \
		install --prefix="/usr" --root="$(PKG_INSTALL_DIR)/py2" \
	)
	$(call Build/Compile/Py3Mod,., \
		install --prefix="/usr" --root="$(PKG_INSTALL_DIR)/py3" \
	)
endef

PKG_INSTALL_DIR_ORIG:="$(PKG_INSTALL_DIR)"
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)/py2"
$(eval $(call PyPackage,python-jsonschema))
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)/py3"
$(eval $(call Py3Package,python3-jsonschema))
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)"

$(eval $(call BuildPackage,python-jsonschema))
$(eval $(call BuildPackage,python3-jsonschema))
