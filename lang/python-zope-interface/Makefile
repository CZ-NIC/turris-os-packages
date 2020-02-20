#
# Copyright (C) 2013-2020 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-zope-interface
PKG_VERSION:=4.7.1
PKG_RELEASE:=1

PYPI_NAME:=zope.interface
PKG_HASH:=4bb937e998be9d5e345f486693e477ba79e4344674484001a0b646be1d530487

PKG_MAINTAINER:=
PKG_LICENSE:=ZPL-2.1
PKG_LICENSE_FILES:=LICENSE.txt

include $(TOPDIR)/feeds/packages/lang/python/pypi.mk
include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-zope-interface
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Interfaces for Python
  URL:=https://github.com/zopefoundation/zope.interface
  DEPENDS:=+python3-light
  VARIANT:=python3
endef

define Package/python3-zope-interface/description
  This package provides an implementation of "object interfaces" for Python. 
  Interfaces are a mechanism for labeling objects as conforming to a given API or contract.
endef

$(eval $(call Py3Package,python3-zope-interface))
$(eval $(call BuildPackage,python3-zope-interface))
$(eval $(call BuildPackage,python3-zope-interface-src))
