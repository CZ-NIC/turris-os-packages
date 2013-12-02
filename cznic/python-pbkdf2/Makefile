#
# Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pbkdf2
PKG_VERSION:=1.3
PKG_RELEASE:=1

PKG_SOURCE:=pbkdf2-1.3.tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/p/pbkdf2/
PKG_MD5SUM:=40cda566f61420490206597243dd869f

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/python-pbkdf2
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	TITLE:=python-pbkdf2
	URL:=https://www.dlitz.net/software/python-pbkdf2/
	DEPENDS:=+python
	MAINTAINER:=Jan Cermak <jan.cermak@nic.cz>
endef

define Package/python-pbkdf2/description
	PKCS#5 v2.0 PBKDF2 Module for Python
endef

define Build/Compile
	$(call Build/Compile/PyMod,., \
		install --prefix="/usr" --root="$(PKG_INSTALL_DIR)" \
	)
endef

define Package/python-pbkdf2/install
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)/
	$(CP) \
		$(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* \
		$(1)$(PYTHON_PKG_DIR)/
endef

$(eval $(call BuildPackage,python-pbkdf2))
