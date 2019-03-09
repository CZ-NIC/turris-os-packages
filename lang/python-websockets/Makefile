#
# Copyright (C) 2018-2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-websockets
PKG_VERSION:=7.0
PKG_RELEASE:=1

PKG_SOURCE_URL:=https://pypi.python.org/packages/source/w/websockets/
PKG_SOURCE_SUBDIR:=websockets-$(PKG_VERSION)
PKG_SOURCE:=websockets-$(PKG_VERSION).tar.gz
PKG_HASH=08e3c3e0535befa4f0c4443824496c03ecc25062debbcf895874f8a0b4c97c9f

PKG_LICENSE:=BSD

PKG_BUILD_DIR:=$(BUILD_DIR)/python3-websockets-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

PKG_UNPACK:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

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
  websockets is a library for building WebSocket servers and clients in Python with a focus on correctness and simplicity.

  Built on top of asyncio, Python’s standard asynchronous I/O framework, it provides an elegant coroutine-based API.
endef

$(eval $(call Py3Package,python3-websockets))
$(eval $(call BuildPackage,python3-websockets))
