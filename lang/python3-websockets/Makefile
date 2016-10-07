#
# Copyright (C) 2016 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python3-websockets
PKG_VERSION:=3.2
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/aaugustin/websockets.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=3.2
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz


PKG_BUILD_DIR:=$(BUILD_DIR)/python3-websockets-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

define Package/python3-websockets
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=library for developing WebSocket servers and clients
  URL:=https://websockets.readthedocs.io/
  DEPENDS:=+python3
endef

define Package/python3-pyserial/description
  websockets is a library for developing WebSocket servers and clients in Python. It implements RFC 6455 with a focus on correctness and simplicity. It passes the Autobahn Testsuite.
  Built on top of Python's asynchronous I/O support introduced in PEP 3156, it provides an API based on coroutines, making it easy to write highly concurrent applications.
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,, \
		install --root="$(PKG_INSTALL_DIR)" --prefix="/usr"  \
	)
endef

$(eval $(call Py3Package,python3-websockets))
$(eval $(call BuildPackage,python3-websockets))
