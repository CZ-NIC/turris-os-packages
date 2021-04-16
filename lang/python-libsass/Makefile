#
# Copyright (C) 2018-2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-libsass
PKG_VERSION:=0.20.1
PKG_RELEASE:=1

PYPI_NAME:=libsass
PKG_HASH:=e0e60836eccbf2d9e24ec978a805cd6642fa92515fbd95e3493fee276af76f8a

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
