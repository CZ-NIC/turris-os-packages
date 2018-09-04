#
# Copyright (C) 2018 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-jinja2
PKG_VERSION:=2.10
PKG_RELEASE:=1

PKG_SOURCE:=Jinja2-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://files.pythonhosted.org/packages/source/j/jinja2/

PKG_MD5SUM:=61ef1117f945486472850819b8d1eb3d

PKG_BUILD_DIR:=$(BUILD_DIR)/Jinja2-$(PKG_VERSION)
HOST_BUILD_DIR:=$(BUILD_DIR_HOST)/Jinja2-$(PKG_VERSION)

PKG_BUILD_DEPENDS:=python python3
HOST_BUILD_DEPENDS:=python/host python-setuptools/host python3/host python3-setuptools/host

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk
$(call include_mk, python-package.mk)
$(call include_mk, python-host.mk)
$(call include_mk, python3-package.mk)
$(call include_mk, python3-host.mk)

define Package/Common
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	URL:=http://jinja.pocoo.org/
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef

define Package/python-jinja2
	$(call Package/Common)
	TITLE:=python-jinja2
	DEPENDS:=+python-light +python-markupsafe
endef

define Package/python3-jinja2
	$(call Package/Common)
	TITLE:=python3-jinja2
	DEPENDS:=+python-light +python3-markupsafe
endef

define Package/$(PKG_NAME)/description
	Jinja2 is a template engine written in pure Python. It provides a Django inspired non-XML syntax but supports inline expressions and an optional sandboxed environment.
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix="/usr" --root=$(PKG_INSTALL_DIR)/py2)
	$(call Build/Compile/Py3Mod,,install --prefix="/usr" --root=$(PKG_INSTALL_DIR)/py3)
endef

define Host/Compile
	$(call Build/Compile/HostPyMod,,build)
	$(call Build/Compile/HostPy3Mod,,build)
endef

define Host/Install
	$(call Build/Compile/HostPyMod,,install --prefix="" --root="$(STAGING_DIR_HOSTPKG)")
	$(call Build/Compile/HostPy3Mod,,install --prefix="" --root="$(STAGING_DIR_HOSTPKG)")
endef

$(eval $(call HostBuild))

PKG_INSTALL_DIR_ORIG:="$(PKG_INSTALL_DIR)"
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)/py2"
$(eval $(call PyPackage,python-jinja2))
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)/py3"
$(eval $(call Py3Package,python3-jinja2))
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)"

$(eval $(call BuildPackage,python-jinja2))
$(eval $(call BuildPackage,python3-jinja2))
