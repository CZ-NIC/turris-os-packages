#
# Copyright (C) 2018 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=websocket_server
PKG_VERSION:=0.4
PKG_RELEASE:=6

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/74/64/e86581ee7775a2e08aca530b41e1a1e3ee6b320233b1eff301dcb86d1636/
PKG_MD5SUM:=0026f2a6696e2ebdb4c70a35568ff22c

PKG_LICENSE:=MIT
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

PKG_BUILD_DEPENDS:=python-setuptools

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)
$(call include_mk, python3-package.mk)

define Package/Common
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	URL:=https://github.com/Pithikos/python-websocket-server
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef

define Package/python-websocket-server
	$(call Package/Common)
	TITLE:=python-websocket-server
	DEPENDS:=+python-light
endef

define Package/python3-websocket-server
	$(call Package/Common)
	TITLE:=python3-websocket-server
	DEPENDS:=+python3-light
endef

define Package/python-websocket-server/description
A minimalistic websocket server implementation with no dependencies that works both Python2 and Python3.
endef

define Build/Compile
	$(call Build/Compile/PyMod,., \
		install --prefix="/usr" --root="$(PKG_INSTALL_DIR)/py2" \
	)
	$(call Build/Compile/Py3Mod,., \
		install --prefix="/usr" --root="$(PKG_INSTALL_DIR)/py3" \
	)
endef

PKG_INSTALL_DIR_ORIG:="$(PKG_INSTALL_DIR)"
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)/py2"
$(eval $(call PyPackage,python-websocket-server))
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)/py3"
$(eval $(call Py3Package,python3-websocket-server))
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)"

$(eval $(call BuildPackage,python-websocket-server))
$(eval $(call BuildPackage,python3-websocket-server))
