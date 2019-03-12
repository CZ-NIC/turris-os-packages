#
# Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=bottle
PKG_VERSION:=0.12.13
PKG_RELEASE:=1

PKG_SOURCE:=bottle-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.io/packages/source/b/bottle/
PKG_MD5SUM:=d2fe1b48c1d49217e78bf326b1cad437

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python python-setuptools python3 python3-setuptools

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)
$(call include_mk, python3-package.mk)

define Package/Common
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	URL:=http://bottlepy.org
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef

define Package/python-bottle
	$(call Package/Common)
	TITLE:=python-bottle
	DEPENDS:=+python-light +python-codecs +python-email
endef

define Package/python3-bottle
	$(call Package/Common)
	TITLE:=python3-bottle
	DEPENDS:=+python3-light +python3-codecs +python3-email
endef

define Package/python-bottle/description
	Fast and simple WSGI-framework for small web-applications.
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix="/usr" --root=$(PKG_INSTALL_DIR)/py2)
	$(call Build/Compile/Py3Mod,,install --prefix="/usr" --root=$(PKG_INSTALL_DIR)/py3)
endef

PKG_INSTALL_DIR_ORIG:="$(PKG_INSTALL_DIR)"
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)/py2"
$(eval $(call PyPackage,python-bottle))
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)/py3"
$(eval $(call Py3Package,python3-bottle))
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)"

$(eval $(call BuildPackage,python-bottle))
$(eval $(call BuildPackage,python3-bottle))
