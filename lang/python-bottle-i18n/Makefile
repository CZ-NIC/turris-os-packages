#
# Copyright (C) 2013-2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-bottle-i18n
PKG_VERSION:=0.1.5
PKG_RELEASE:=4

PKG_SOURCE:=bottle-i18n-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://files.pythonhosted.org/packages/source/b/bottle-i18n/
PKG_HASH:=7f9d343ae30b18a9676cbe612a8be2e99d4741aa4aa6a1b875ea232ba94c7678

PKG_BUILD_DIR:=$(BUILD_DIR)/bottle-i18n-$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=MIT

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-bottle-i18n
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=python3-bottle-i18n
  URL:=https://github.com/iocast/bottle-i18n
  DEPENDS:=+python3-light +python3-bottle
  VARIANT:=python3
endef

define Package/python3-bottle-i18n/description
  i18n support for bottle.py
endef

PYTHON3_PKG_SETUP_ARGS:=

$(eval $(call Py3Package,python3-bottle-i18n))
$(eval $(call BuildPackage,python3-bottle-i18n))
$(eval $(call BuildPackage,python3-bottle-i18n-src))
