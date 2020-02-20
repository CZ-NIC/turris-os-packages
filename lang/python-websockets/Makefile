#
# Copyright (C) 2018-2020 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-websockets
PKG_VERSION:=8.1
PKG_RELEASE:=1

PYPI_NAME:=websockets
PKG_HASH=5c65d2da8c6bce0fca2528f69f44b2f977e06954c8512a952222cea50dad430f

PKG_MAINTAINER:=
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE

include $(TOPDIR)/feeds/packages/lang/python/pypi.mk
include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-websockets
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=library for developing WebSocket servers and clients
  URL:=https://websockets.readthedocs.io/
  DEPENDS:=+python3-light
  VARIANT:=python3
endef

define Package/python3-websockets/description
  websockets is a library for building WebSocket servers and clients
  in Python with a focus on correctness and simplicity.

  Built on top of asyncio, Python’s standard asynchronous I/O framework.
  It provides an elegant coroutine-based API.
endef

$(eval $(call Py3Package,python3-websockets))
$(eval $(call BuildPackage,python3-websockets))
$(eval $(call BuildPackage,python3-websockets-src))
