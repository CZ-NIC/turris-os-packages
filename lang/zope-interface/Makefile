#
# Copyright (C) 2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=zope-interface
PKG_VERSION:=4.6.0
PKG_RELEASE:=1

PKG_SOURCE:=zope.interface-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/z/zope-interface/
PKG_HASH:=1b3d0dcabc7c90b470e59e38a9acaa361be43b3a6ea644c0063951964717f0e5

PKG_BUILD_DIR:=$(BUILD_DIR)/zope.interface-$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=ZPL-2.1
PKG_LICENSE_FILES:=LICENSE.txt

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-zope-interface
  SECTION:=lang
  CATEGORY:=Languages
  SUBMENU:=Python
  TITLE:=Interfaces for Python
  URL:=https://github.com/zopefoundation/zope.interface
  DEPENDS:= \
	+python3-light
  VARIANT:=python3
endef

define Package/python3-zope-interface/description
  This package provides an implementation of "object interfaces" for Python.
endef

$(eval $(call Py3Package,python3-zope-interface))
$(eval $(call BuildPackage,python3-zope-interface))
$(eval $(call BuildPackage,python3-zope-interface-src))
