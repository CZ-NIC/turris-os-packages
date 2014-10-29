#
# Copyright (C) 2014 CZ.NIC, z. s. p. o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ply
PKG_VERSION:=3.4
PKG_RELEASE:=1

PKG_SOURCE:=ply-3.4.tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/p/ply/
PKG_MD5SUM:=ffdc95858819347bf92d7c2acc074894

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
HOST_BUILD_DEPENDS:=python/host python

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk
$(call include_mk, python-package.mk)

define Package/python-ply
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	TITLE:=python-ply
	URL:=http://www.dabeaz.com/ply/
	DEPENDS:=+python
	MAINTAINER:=Jan Cermak <jan.cermak@nic.cz>
endef

define Package/python-ply/description
	Python Lex & Yacc
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix=/usr --root=$(PKG_INSTALL_DIR))
endef

define Host/Compile
	$(call Build/Compile/Host/PyMod,,install --prefix=$(STAGING_DIR_HOST))
endef

define Host/Install
endef

define Package/python-ply/install
endef

$(eval $(call BuildPackage,python-ply))
$(eval $(call HostBuild))
