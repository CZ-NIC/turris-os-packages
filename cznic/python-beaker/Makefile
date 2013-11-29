#
# Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=Beaker
PKG_VERSION:=1.6.4
PKG_RELEASE:=1

PKG_SOURCE:=Beaker-1.6.4.tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/B/Beaker/
PKG_MD5SUM:=c2e102870ed4c53104dec48ceadf8e9d

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/python-beaker
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	TITLE:=python-beaker
	URL:=http://beaker.readthedocs.org
	DEPENDS:=+python
	MAINTAINER:=Jan Cermak <jan.cermak@nic.cz>
endef

define Package/python-beaker/description
	A Session and Caching library with WSGI Middleware
endef

define Build/Compile
	$(call Build/Compile/PyMod,., \
		install --prefix="/usr" --root="$(PKG_INSTALL_DIR)" \
	)
endef

define Package/python-beaker/install
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)/
	$(CP) \
		$(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* \
		$(1)$(PYTHON_PKG_DIR)/
endef

$(eval $(call BuildPackage,python-beaker))
