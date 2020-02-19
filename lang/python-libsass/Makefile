#
# Copyright (C) 2018-2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-libsass
PKG_VERSION:=0.19.4
PKG_RELEASE:=1

PYPI_NAME:=libsass
PKG_HASH:=8b5b6d1a7c4ea1d954e0982b04474cc076286493f6af2d0a13c2e950fbe0be95

include $(TOPDIR)/feeds/packages/lang/python/pypi.mk
include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-libsass
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Sass/SCSS for Python
  URL:=https://github.com/sass/libsass-python
  DEPENDS:=+libstdcpp +python3-light
  VARIANT:=python3
endef

define Package/python3-libsass/description
  A straightforward binding of libsass for Python.
endef

$(eval $(call Py3Package,python3-libsass))
$(eval $(call BuildPackage,python3-libsass))
$(eval $(call BuildPackage,python3-libsass-src))
