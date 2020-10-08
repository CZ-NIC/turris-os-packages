#
# Copyright (C) 2018-2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=reforis-distutils
PKG_VERSION:=0.1.0
PKG_RELEASE:=3

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/reforis/reforis-distutils.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

HOST_PYTHON3_PACKAGE_BUILD_DEPENDS:= \
	Babel \

HOST_BUILD_DEPENDS:= \
	python3/host \
	node/host \

include $(INCLUDE_DIR)/host-build.mk
include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/reforis-distutils
  SECTION:=web
  CATEGORY:=Web
  SUBMENU:=reForis
  TITLE:=reForis distutils
  URL:=https://gitlab.nic.cz/turris/reforis/reforis-distutils
  DEPENDS:=\
    +python3-light \
    +python3-babel
  VARIANT:=python3
endef

define Package/reforis-distutils/description
  Distutils to build reforis and its plugins.
endef

define Host/Compile
	$(call Build/Compile/HostPy3Mod,,install --prefix="" --root="$(STAGING_DIR_HOSTPKG)")
endef

Host/Install:=

$(eval $(call HostBuild))

$(eval $(call Py3Package,reforis-distutils))
$(eval $(call BuildPackage,reforis-distutils))
$(eval $(call BuildPackage,reforis-distutils-src))
