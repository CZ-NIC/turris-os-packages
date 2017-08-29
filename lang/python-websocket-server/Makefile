#
# Copyright (C) 2017 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=websocket_server
PKG_VERSION:=0.4
PKG_RELEASE:=4

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/74/64/e86581ee7775a2e08aca530b41e1a1e3ee6b320233b1eff301dcb86d1636/
PKG_MD5SUM:=0026f2a6696e2ebdb4c70a35568ff22c

PKG_LICENSE:=MIT
PKG_MAINTAINER:=Stepah Henek <stepan.henek@nic.cz>

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/python-websocket-server
	SECTION:=lang
	CATEGORY:=Languages
	SUBMENU:=Python
	TITLE:=python-websocket-server
	URL:=https://github.com/Pithikos/python-websocket-server
	DEPENDS:=+python-light
endef

define Package/python-websocket-server/description
A minimalistic websocket server implementation with no dependencies that works both Python2 and Python3.
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix="/usr" --root="$(PKG_INSTALL_DIR)")
endef

$(eval $(call PyPackage,python-websocket-server))
$(eval $(call BuildPackage,python-websocket-server))
