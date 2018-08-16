#
# Copyright (C) 2015 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python3-babel
PKG_VERSION:=2.6.0
PKG_RELEASE:=1

PKG_SOURCE:=Babel-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/b/babel/
PKG_MD5SUM:=c384ac03026e8fe6f9b90f55201f1bff

PKG_BUILD_DIR:=$(BUILD_DIR)/Babel-$(PKG_VERSION)
HOST_BUILD_DIR:=$(BUILD_DIR_HOST)/Babel-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python3-setuptools python3-pytz
HOST_BUILD_DEPENDS:=python3/host

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk
$(call include_mk, python3-package.mk)
$(call include_mk, python3-host.mk)

define Package/python3-babel
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=World timezone definitions, modern and historical
  URL:=http://babel.pocoo.org/en/latest/
  DEPENDS:=+python3
endef

define Package/python3-babel/description
Babel is an integrated collection of utilities that assist in internationalizing and localizing Python applications, with an emphasis on web-based applications.
endef

define Host/Compile
	$(call Build/Compile/HostPy3Mod,,build)
endef

define Host/Install
	$(call Build/Compile/HostPy3Mod,,install --prefix="" --root="$(STAGING_DIR_HOSTPKG)")
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,, \
		install --root="$(PKG_INSTALL_DIR)" --prefix="/usr"  \
		--single-version-externally-managed \
	)
endef

$(eval $(call HostBuild))

$(eval $(call Py3Package,python3-babel))
$(eval $(call BuildPackage,python3-babel))
