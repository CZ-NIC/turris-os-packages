#
# Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=bottle
PKG_VERSION:=0.12.11
PKG_RELEASE:=1

PKG_SOURCE:=bottle-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.io/packages/source/b/bottle/
PKG_MD5SUM:=6c38912f4755ba71d852fbe320bdd61c

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python python-setuptools

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/python-bottle
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	TITLE:=python-bottle
	URL:=http://bottlepy.org
	DEPENDS:=+python-light +python-codecs +python-email
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef

define Package/python-bottle/description
	Fast and simple WSGI-framework for small web-applications.
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix=/usr --root=$(PKG_INSTALL_DIR))
endef

define Package/python-bottle/install
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)
	$(CP) \
		$(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* \
		$(1)$(PYTHON_PKG_DIR)
endef

$(eval $(call BuildPackage,python-bottle))
