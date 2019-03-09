#
# Copyright (C) 2015-2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-netdisco
PKG_VERSION:=2.3.0
PKG_RELEASE:=2

PKG_SOURCE:=netdisco-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/n/netdisco/
PKG_HASH:=2571fc094f3bf8c60be211e90474515f565f3ef1c92e857176daab8577493a3b

PKG_BUILD_DIR:=$(BUILD_DIR)/netdisco-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-netdisco
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Discover devices on your local network
  URL:=http://github.com/balloob/netdisco
  DEPENDS:=+python3-light +python3-requests +python3-zeroconf
  VARIANT:=python3
endef

define Package/python3-netdisco/description
  Discover devices on your local network
endef

$(eval $(call Py3Package,python3-netdisco))
$(eval $(call BuildPackage,python3-netdisco))
$(eval $(call BuildPackage,python3-netdisco-src))
