#
# Copyright (C) 2017-2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-msgpack
PKG_VERSION:=0.6.1
PKG_RELEASE:=1

PKG_SOURCE:=v$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/msgpack/msgpack-python/archive/
PKG_HASH:=734e1abc6f14671f28acd5266de336ae6d8de522fe1c8d0b7146365ad1fe6b0f

PKG_BUILD_DIR:=$(BUILD_DIR)/msgpack-python-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-msgpack
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Python msgpack library
  URL:=https://pypi.python.org/pypi/msgpack
  DEPENDS:=+python3-light +libstdcpp
  VARIANT:=python3
endef

$(eval $(call Py3Package,python3-msgpack))
$(eval $(call BuildPackage,python3-msgpack))
$(eval $(call BuildPackage,python3-msgpack-src))
