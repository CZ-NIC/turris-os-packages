#
# Copyright (C) 2018-2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-websocket-server
PKG_VERSION:=0.4
PKG_RELEASE:=7

PYPI_NAME:=websocket-server
PYPI_SOURCE_NAME:=websocket_server
PKG_HASH:=91cd4b565d1e1b00ef107abcb2840a8090868b19543f3b38e1962d5f975d0c04

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

include $(TOPDIR)/feeds/packages/lang/python/pypi.mk
include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-websocket-server
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=A minimal websocket server
  URL:=https://github.com/Pithikos/python-websocket-server
  DEPENDS:=+python3-light
  VARIANT:=python3
endef

define Package/python3-websocket-server/description
  A minimalistic websocket server implementation with no dependencies.
endef

$(eval $(call Py3Package,python3-websocket-server))
$(eval $(call BuildPackage,python3-websocket-server))
$(eval $(call BuildPackage,python3-websocket-server-src))
