#
# Copyright (C) 2018-2019 CZ.NIC z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-plugins-distutils
PKG_VERSION:=0.3
PKG_RELEASE:=3

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/foris/foris-plugins-distutils
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=LICENSE
PKG_LICENSE_FILES:=GPL-3.0-or-later

PKG_BUILD_DEPENDS:=python-libsass
HOST_PYTHON3_PACKAGE_BUILD_DEPENDS:=libsass==0.14.5
HOST_BUILD_DEPENDS:=python3/host

include $(INCLUDE_DIR)/host-build.mk
include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/foris-plugins-distutils
  SECTION:=web
  CATEGORY:=Web
  SUBMENU:=Foris
  TITLE:=Foris Distutils plugins
  URL:=https://gitlab.nic.cz/turris/foris/foris-plugins-distutils
  DEPENDS:=+python3-light
  VARIANT:=python3
endef

define Package/foris-plugins-distutils/description
  Distutils to build foris plugins.
endef

define Host/Compile
	$(call Build/Compile/HostPy3Mod,,install --prefix="" --root="$(STAGING_DIR_HOSTPKG)")
endef

Host/Install:=

$(eval $(call HostBuild))

$(eval $(call Py3Package,foris-plugins-distutils))
$(eval $(call BuildPackage,foris-plugins-distutils))
$(eval $(call BuildPackage,foris-plugins-distutils-src))
