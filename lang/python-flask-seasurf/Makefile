#
# Copyright (C) 2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-flask-seasurf
PKG_VERSION:=0.2.2
PKG_RELEASE:=1

PKG_SOURCE:=Flask-SeaSurf-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://files.pythonhosted.org/packages/source/f/flask-seasurf/
PKG_HASH:=c57918c17e9afd988bdc30d8dcb7bfb833741dee38b06c1bbd17821d6fa2b6cf

PKG_BUILD_DIR:=$(BUILD_DIR)/Flask-SeaSurf-$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-flask-seasurf
  SECTION:=lang
  CATEGORY:=Languages
  SUBMENU:=Python
  TITLE:=Flask SeaSurf
  URL:=https://flask-seasurf.readthedocs.io/en/latest/
  DEPENDS:=+python3-light +python3-flask
  VARIANT:=python3
endef

define Package/python3-flask-seasurf/description
  SeaSurf is a Flask extension for preventing cross-site request forgery (CSRF).
endef

$(eval $(call Py3Package,python3-flask-seasurf))
$(eval $(call BuildPackage,python3-flask-seasurf))
$(eval $(call BuildPackage,python3-flask-seasurf-src))
