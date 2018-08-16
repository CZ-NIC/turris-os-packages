#
# Copyright (C) 2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=flup
PKG_VERSION:=1.0.3
PKG_RELEASE:=1

PKG_SOURCE:=flup-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/f/flup/
PKG_MD5SUM:=a64e7a6374e043480ee92534c735964e

PKG_LICENSE:=BSD
PKG_LICENSE_FILES:PKG-INFO

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python python3

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)
$(call include_mk, python3-package.mk)

define Package/Common
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	URL:=http://pypi.python.org/pypi/flup/
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef

define Package/python-flup
	$(call Package/Common)
	TITLE:=python-flup
	DEPENDS:=+python-light +python-logging
endef

define Package/python3-flup
	$(call Package/Common)
	TITLE:=python3-flup
	DEPENDS:=+python3-light +python3-logging
endef

define Package/python-flup/description
  Random assortment of WSGI servers
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix="/usr" --root=$(PKG_INSTALL_DIR)/py2)
	$(call Build/Compile/Py3Mod,,install --prefix="/usr" --root=$(PKG_INSTALL_DIR)/py3)
endef

PKG_INSTALL_DIR_ORIG:="$(PKG_INSTALL_DIR)"
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)/py2"
$(eval $(call PyPackage,python-flup))
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)/py3"
$(eval $(call Py3Package,python3-flup))
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)"

$(eval $(call BuildPackage,python-flup))
$(eval $(call BuildPackage,python3-flup))
