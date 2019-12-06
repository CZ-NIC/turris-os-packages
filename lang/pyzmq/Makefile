#
# Copyright (C) 2017-2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pyzmq
PKG_VERSION:=18.1.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://files.pythonhosted.org/packages/source/p/pyzmq/
PKG_HASH:=8c69a6cbfa94da29a34f6b16193e7c15f5d3220cb772d6d17425ff3faa063a6d

PKG_BUILD_DEPENDS:=cython

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-zmq
  SECTION:=lang
  CATEGORY:=Languages
  SUBMENU:=Python
  TITLE:=Python bindings for 0MQ
  URL:=https://github.com/zeromq/pyzmq
  DEPENDS:=+python3 +libzmq
  VARIANT:=python3
endef

define Package/python3-zmq/description
  This package contains Python bindings for 0MQ.
  0MQ is a lightweight and fast messaging implementation.
endef

define prepare_pyzmq_setup
	$(CP) ./files/setup.cfg $(PKG_BUILD_DIR)/setup.cfg
endef

Hooks/Compile/Pre += prepare_pyzmq_setup

PYTHON3_PKG_SETUP_ARGS:=

$(eval $(call Py3Package,python3-zmq))
$(eval $(call BuildPackage,python3-zmq))
$(eval $(call BuildPackage,python3-zmq-src))
