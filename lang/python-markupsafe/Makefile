#
# Copyright (C) 2018 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-markupsafe
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_SOURCE:=MarkupSafe-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://files.pythonhosted.org/packages/source/m/markupsafe/

PKG_BUILD_DIR:=$(BUILD_DIR)/MarkupSafe-$(PKG_VERSION)
HOST_BUILD_DIR:=$(BUILD_DIR_HOST)/MarkupSafe-$(PKG_VERSION)

PKG_BUILD_DEPENDS:=python python3
HOST_BUILD_DEPENDS:=python/host python3/host

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
	URL:=https://github.com/pallets/markupsafe
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef

define Package/python-markupsafe
	TITLE:=python-markupsafe
	DEPENDS:=+python-light
endef

define Package/python3-markupsafe
	TITLE:=python-markupsafe
	DEPENDS:=+python3-light
endef

define Package/$(PKG_NAME)/description
	Safely add untrusted strings to HTML/XML markup.
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
$(eval $(call PyPackage,python-markupsafe))
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)/py3"
$(eval $(call Py3Package,python3-markupsafe))
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)"

$(eval $(call BuildPackage,python-markupsafe))
$(eval $(call BuildPackage,python3-markupsafe))
