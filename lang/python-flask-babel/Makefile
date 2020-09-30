#
# Copyright (C) 2019-2020 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-flask-babel
PKG_VERSION:=2.0.0
PKG_RELEASE:=1

PYPI_NAME:=Flask-Babel
PKG_HASH:=f9faf45cdb2e1a32ea2ec14403587d4295108f35017a7821a2b1acb8cfd9257d

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE

include $(TOPDIR)/feeds/packages/lang/python/pypi.mk
include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-flask-babel
  SECTION:=lang
  CATEGORY:=Languages
  SUBMENU:=Python
  TITLE:=Flask Babel
  URL:=https://github.com/python-babel/flask-babel
  DEPENDS:= \
  +python3-light \
  +python3-flask \
  +python3-babel \
  +python3-jinja2 \
  +python3-pytz
  VARIANT:=python3
endef

define Package/python3-flask-babel/description
  Implements i18n and l10n support for Flask.
  This is based on the Python babel module as well as pytz
  both of which are installed automatically for you if you install this library.
endef

$(eval $(call Py3Package,python3-flask-babel))
$(eval $(call BuildPackage,python3-flask-babel))
$(eval $(call BuildPackage,python3-flask-babel-src))
