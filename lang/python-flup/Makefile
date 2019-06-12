#
# Copyright (C) 2012-2019 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-flup
PKG_VERSION:=1.0.3
PKG_RELEASE:=2

PKG_SOURCE:=flup-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/f/flup/
PKG_HASH:=5eb09f26eb0751f8380d8ac43d1dfb20e1d42eca0fa45ea9289fa532a79cd159

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=BSD
PKG_LICENSE_FILES:=PKG-INFO

PKG_BUILD_DIR:=$(BUILD_DIR)/flup-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-flup
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=python3-flup
  URL:=http://pypi.python.org/pypi/flup/
  DEPENDS:=+python3-light +python3-logging
  VARIANT:=python3
endef

define Package/python3-flup/description
  Random assortment of WSGI servers
endef

$(eval $(call Py3Package,python3-flup))
$(eval $(call BuildPackage,python3-flup))
$(eval $(call BuildPackage,python3-flup-src))
