#
# Copyright (C) 2019-2020 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-babel
PKG_VERSION:=2.8.0
PKG_RELEASE:=2

PYPI_NAME:=Babel
PKG_HASH:=1aac2ae2d0d8ea368fa90906567f5c08463d98ade155c0c4bfedd6a0f7160e38

include $(TOPDIR)/feeds/packages/lang/python/pypi.mk
include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-babel
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Internationalization utilities
  URL:=http://babel.pocoo.org/en/latest/
  DEPENDS:=+python3-light +python3-pytz
  VARIANT:=python3
endef

define Package/python3-babel/description
  Babel is an integrated collection of utilities that assist in
  internationalizing and localizing Python applications
  with an emphasis on web-based applications.
endef

$(eval $(call Py3Package,python3-babel))
$(eval $(call BuildPackage,python3-babel))
$(eval $(call BuildPackage,python3-babel-src))
