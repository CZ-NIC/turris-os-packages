#
# Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=zope-interface
PKG_VERSION:=4.1.1
PKG_RELEASE:=1

PKG_SOURCE:=zope.interface-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/z/zope.interface/
PKG_MD5SUM:=edcd5f719c5eb2e18894c4d06e29b6c6

PKG_BUILD_DIR:=$(BUILD_DIR)/zope.interface-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/zope-interface
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	TITLE:=zope-interface
	URL:=https://pypi.python.org/pypi/zope.interface/
	DEPENDS:=+python
	MAINTAINER:=Ondrej Mikle <ondrej.mikle@nic.cz>
endef

define Package/zope-interface/description
	This package provides an implementation of "object interfaces" for Python.
endef

define Build/Compile
	$(call Build/Compile/PyMod,., \
		install --prefix="/usr" --root="$(PKG_INSTALL_DIR)" \
	)
endef

define Package/zope-interface/install
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)/
	$(CP) \
		$(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* \
		$(1)$(PYTHON_PKG_DIR)/
endef

$(eval $(call BuildPackage,zope-interface))
