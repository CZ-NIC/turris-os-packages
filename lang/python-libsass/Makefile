#
# Copyright (C) 2018 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-libsass
PKG_VERSION:=0.14.5
PKG_RELEASE:=2

PKG_SOURCE:=libsass-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://files.pythonhosted.org/packages/source/l/libsass/

PKG_MD5SUM:=86934693e4825b360594e88a734c3b72

PKG_BUILD_DIR:=$(BUILD_DIR)/$(BUILD_VARIANT)-libsass-$(PKG_VERSION)
HOST_BUILD_DIR:=$(BUILD_DIR_HOST)/$(BUILD_VARIANT)-libsass-$(PKG_VERSION)

HOST_BUILD_DEPENDS:=python/host python3/host

include $(INCLUDE_DIR)/host-build.mk
include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python-package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

PKG_UNPACK:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)
HOST_UNPACK:=$(HOST_TAR) -C $(HOST_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

define Package/python-libsass/Default
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	URL:=https://github.com/sass/libsass-python
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
	DEPENDS:=+libstdcpp
endef

define Package/python-libsass
	$(call Package/python-libsass/Default)
	TITLE:=python-libsass
	DEPENDS+=+python-light
	VARIANT:=python
endef

define Package/python3-libsass
	$(call Package/python-libsass/Default)
	TITLE:=python3-libsass
	DEPENDS+=+python3-light
	VARIANT:=python3
endef

define Package/python-libsass/description
	A straightforward binding of libsass for Python.
endef

define Package/python3-libsass/description
  $(call Package/python-libsass/description)
  .
  (Variant for Python3)
endef

define Host/Compile
	$(call Build/Compile/HostPyMod,,install --prefix="" --root="$(STAGING_DIR_HOSTPKG)")
	$(call Build/Compile/HostPy3Mod,,install --prefix="" --root="$(STAGING_DIR_HOSTPKG)")
endef

Host/Install:=

$(eval $(call HostBuild))

$(eval $(call PyPackage,python-libsass))
$(eval $(call BuildPackage,python-libsass))
$(eval $(call BuildPackage,python-libsass-src))

$(eval $(call Py3Package,python3-libsass))
$(eval $(call BuildPackage,python3-libsass))
$(eval $(call BuildPackage,python3-libsass-src))
