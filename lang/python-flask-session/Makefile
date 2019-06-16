#
# Copyright (C) 2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-flask-session
PKG_VERSION:=0.3.1
PKG_RELEASE:=1

PKG_SOURCE:=Flask-Session-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://files.pythonhosted.org/packages/source/f/flask-session/
PKG_HASH:=a31c27e0c3287f00c825b3d9625aba585f4df4cccedb1e7dd5a69a215881a731

PKG_BUILD_DIR:=$(BUILD_DIR)/Flask-Session-$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-flask-session
  SECTION:=lang
  CATEGORY:=Languages
  SUBMENU:=Python
  TITLE:=Flask Session
  URL:=https://github.com/fengsp/flask-session
  DEPENDS:=+python3-light +python3-flask
  VARIANT:=python3
endef

define Package/python3-flask-session/description
  Flask-Session is an extension for Flask that adds support for Server-side Session to your application.
endef

$(eval $(call Py3Package,python3-flask-session))
$(eval $(call BuildPackage,python3-flask-session))
$(eval $(call BuildPackage,python3-flask-session-src))
