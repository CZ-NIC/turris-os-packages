#
# Copyright (C) 2017-2020 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pyzmq
PKG_VERSION:=22.0.3
PKG_RELEASE:=1

PYPI_NAME:=pyzmq
PKG_HASH:=f7f63ce127980d40f3e6a5fdb87abf17ce1a7c2bd8bf2c7560e1bbce8ab1f92d

PKG_BUILD_DEPENDS:=cython

include $(TOPDIR)/feeds/packages/lang/python/pypi.mk
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
