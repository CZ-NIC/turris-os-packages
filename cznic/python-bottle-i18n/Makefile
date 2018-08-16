#
# Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=bottle-i18n
PKG_VERSION:=0.1.5
PKG_RELEASE:=3

PKG_SOURCE:=bottle-i18n-0.1.5.tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/b/bottle-i18n/
PKG_MD5SUM:=f0942f05fec0f4a3c45765623863cb68

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python python-setuptools python3 python3-setuptools

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)
$(call include_mk, python3-package.mk)

define Package/Common
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	URL:=https://github.com/iocast/bottle-i18n
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef

define Package/python-bottle-i18n
	$(call Package/Common)
	TITLE:=python-bottle-i18n
	DEPENDS:=+python-light +python-bottle
endef

define Package/python3-bottle-i18n
	$(call Package/Common)
	TITLE:=python3-bottle-i18n
	DEPENDS:=+python3-light +python3-bottle
endef

define Package/python-bottle-i18n/description
	i18n support for bottle.py
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix="/usr" --root=$(PKG_INSTALL_DIR)/py2)
	$(call Build/Compile/Py3Mod,,install --prefix="/usr" --root=$(PKG_INSTALL_DIR)/py3)
endef

PKG_INSTALL_DIR_ORIG:="$(PKG_INSTALL_DIR)"
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)/py2"
$(eval $(call PyPackage,python-bottle-i18n))
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)/py3"
$(eval $(call Py3Package,python3-bottle-i18n))
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)"

$(eval $(call BuildPackage,python-bottle-i18n))
$(eval $(call BuildPackage,python3-bottle-i18n))
