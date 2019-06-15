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

PKG_SOURCE:=msgpack-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://files.pythonhosted.org/packages/source/m/msgpack/
PKG_HASH:=4008c72f5ef2b7936447dcb83db41d97e9791c83221be13d5e19db0796df1972

PKG_BUILD_DIR:=$(BUILD_DIR)/msgpack-$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=COPYING

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-msgpack
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=MessagePack (de)serializer
  URL:=https://msgpack.org/
  DEPENDS:=+python3-light +libstdcpp
  VARIANT:=python3
endef

$(eval $(call Py3Package,python3-msgpack))
$(eval $(call BuildPackage,python3-msgpack))
$(eval $(call BuildPackage,python3-msgpack-src))
