#
# Copyright (C) 2015-2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-flask-babel
PKG_VERSION:=0.12.2
PKG_RELEASE:=2

PKG_SOURCE:=Flask-Babel-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://files.pythonhosted.org/packages/source/f/flask-babel/
PKG_HASH:=316ad183e42003f3922957fa643d0a1e8e34a0f0301a88c3a8f605bc37ba5c86

PKG_BUILD_DIR:=$(BUILD_DIR)/Flask-Babel-$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-flask-babel
  SECTION:=lang
  CATEGORY:=Languages
  SUBMENU:=Python
  TITLE:=Flask Babel
  URL:=https://github.com/python-babel/flask-babel
  DEPENDS+= \
  +python3-light \
  +python3-flask \
  +python3-babel \
  +python3-jinja2
  VARIANT:=python3
endef

define Package/python3-flask-babel/description
  Implements i18n and l10n support for Flask.
  This is based on the Python babel module as well as pytz both of which are installed automatically for you if you install this library.
endef

$(eval $(call Py3Package,python3-flask-babel))
$(eval $(call BuildPackage,python3-flask-babel))
$(eval $(call BuildPackage,python3-flask-babel-src))
