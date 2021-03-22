#
# Copyright (C) 2015 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python3-six
PKG_VERSION:=1.9.0
PKG_RELEASE:=2

PKG_SOURCE:=six-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/s/six/
PKG_MD5SUM:=476881ef4012262dfc8adc645ee786c4

PKG_BUILD_DIR:=$(BUILD_DIR)/six-$(PKG_VERSION)
HOST_BUILD_DIR:=$(BUILD_DIR_HOST)/six-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python3-setuptools
HOST_BUILD_DEPENDS:=python3/host

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk
$(call include_mk, python3-package.mk)
$(call include_mk, python3-host.mk)


define Package/python3-six
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Python 2 and 3 compatibility utilities
  URL:=http://pypi.python.org/pypi/six/
  DEPENDS:=+python3
endef

define Package/python3-six/description
  Python 2 and 3 compatibility utilities
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

$(eval $(call Py3Package,python3-six))
$(eval $(call BuildPackage,python3-six))
