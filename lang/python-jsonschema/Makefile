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

PKG_BUILD_DIR:=$(BUILD_DIR)/$(BUILD_VARIANT)-jsonschema-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python python3 python-setuptools python3-setuptools

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python-package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

PKG_UNPACK:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

define Package/python-jsonschema/Default
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	URL:=https://python-jsonschema.readthedocs.io/en/latest/
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
	DEPENDS:=
endef

define Package/python-jsonschema
	$(call Package/python-jsonschema/Default)
	TITLE:=python-jsonschema
	DEPENDS+=+PACKAGE_python-jsonschema:python-light +PACKAGE_python-jsonschema:python-functools32
	VARIANT:=python
endef

define Package/python3-jsonschema
	$(call Package/python-jsonschema/Default)
	TITLE:=python3-jsonschema
	DEPENDS+=+PACKAGE_python3-jsonschema:python3-light
	VARIANT:=python3
endef

define Package/python-jsonschema/description
	jsonschema is an implementation of JSON Schema for Python (supporting 2.7+ including Python 3).
endef

define Package/python3-jsonschema/description
	$(call Package/python-jsonschema/description)
	.
	(Variant for Python3)
endef

$(eval $(call PyPackage,python-jsonschema))
$(eval $(call BuildPackage,python-jsonschema))
$(eval $(call BuildPackage,python-jsonschema-src))

$(eval $(call Py3Package,python3-jsonschema))
$(eval $(call BuildPackage,python3-jsonschema))
$(eval $(call BuildPackage,python3-jsonschema-src))
