#
# Copyright (C) 2015-2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-netifaces
PKG_VERSION:=0.10.9
PKG_RELEASE:=2

PKG_SOURCE:=netifaces-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/n/netifaces/
PKG_HASH:=2dee9ffdd16292878336a58d04a20f0ffe95555465fee7c9bd23b3490ef2abf3

PKG_BUILD_DIR:=$(BUILD_DIR)/netifaces-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-netifaces
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Portable network interface information.
  URL:=https://bitbucket.org/al45tair/netifaces
  DEPENDS:=+python3-light
  VARIANT:=python3
endef

define Package/python3-netifaces/description
  Portable network interface information.
endef

$(eval $(call Py3Package,python3-netifaces))
$(eval $(call BuildPackage,python3-netifaces))
$(eval $(call BuildPackage,python3-netifaces-src))
