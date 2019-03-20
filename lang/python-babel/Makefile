#
# Copyright (C) 2015-2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-babel
PKG_VERSION:=2.6.0
PKG_RELEASE:=1

PKG_SOURCE:=Babel-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/b/babel/
PKG_HASH:=8cba50f48c529ca3fa18cf81fa9403be176d374ac4d60738b839122dfaaa3d23
PKG_BUILD_DIR:=$(BUILD_DIR)/Babel-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-babel
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=World timezone definitions, modern and historical
  URL:=http://babel.pocoo.org/en/latest/
  DEPENDS:=+python3-light +python3-pytz
  VARIANT:=python3
endef

define Package/python3-babel/description
  Babel is an integrated collection of utilities that assist in internationalizing and localizing Python applications, with an emphasis on web-based applications.
endef

$(eval $(call Py3Package,python3-babel))
$(eval $(call BuildPackage,python3-babel))
$(eval $(call BuildPackage,python3-babel-src))
