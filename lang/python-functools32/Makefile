#
# Copyright (C) 2017 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-functools32
PKG_RELEASE:=2
PKG_VERSION:=3.2.3-$(PKG_RELEASE)

PKG_SOURCE:=functools32-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://files.pythonhosted.org/packages/source/f/functools32/
PKG_MD5SUM:=

PKG_BUILD_DIR:=$(BUILD_DIR)/functools32-$(PKG_VERSION)
HOST_BUILD_DIR:=$(BUILD_DIR_HOST)/functools32-$(PKG_VERSION)

HOST_BUILD_DEPENDS:=python/host
PKG_BUILD_DEPENDS:=python

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk
$(call include_mk, python-package.mk)
$(call include_mk, python-host.mk)

define Package/$(PKG_NAME)
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	TITLE:=python-functools32
	URL:=https://pypi.python.org/pypi/functools32
	DEPENDS:=+python-light
	MAINTAINER:=Stepan Henek <stepan.henek@nic.cz>
endef

define Package/$(PKG_NAME)/description
	Backport of the functools module from Python 3.2.3 for use on 2.7 and PyPy.
endef

define Build/Compile
	$(call Build/Compile/PyMod,., \
		install --prefix="/usr" --root="$(PKG_INSTALL_DIR)" \
	)
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)/
	$(CP) \
		$(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* \
		$(1)$(PYTHON_PKG_DIR)/
endef


define Host/Compile
	#$(call Build/Compile/HostPyMod,,build)
endef

define Host/Install
	$(call Build/Compile/HostPyMod,,install --prefix="" --root="$(STAGING_DIR)/host")
endef

$(eval $(call HostBuild))

$(eval $(call PyPackage,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_NAME)))
