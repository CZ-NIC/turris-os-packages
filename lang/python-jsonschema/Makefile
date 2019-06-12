#
# Copyright (C) 2018-2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-jsonschema
PKG_VERSION:=3.0.1
PKG_RELEASE:=4

PKG_SOURCE:=jsonschema-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://files.pythonhosted.org/packages/source/j/jsonschema/
PKG_HASH:=0c0a81564f181de3212efa2d17de1910f8732fa1b71c42266d983cd74304e20d

PKG_BUILD_DIR:=$(BUILD_DIR)/jsonschema-$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=COPYING

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-jsonschema
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=An implementation of JSON Schema validation for Python
  URL:=https://github.com/Julian/jsonschema
  DEPENDS:=+python3-light +python3-attrs +python3-six +python3-pyrsistent
  VARIANT:=python3
endef

define Package/python3-jsonschema/description
  jsonschema is an implementation of JSON Schema for Python.
endef

$(eval $(call Py3Package,python3-jsonschema))
$(eval $(call BuildPackage,python3-jsonschema))
$(eval $(call BuildPackage,python3-jsonschema-src))
