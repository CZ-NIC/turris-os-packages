#
# Copyright (C) 2015 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python3-zeroconf
PKG_VERSION:=0.17.3
PKG_RELEASE:=2

PKG_SOURCE:=zeroconf-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/z/zeroconf/
PKG_MD5SUM:=8b08e391276b4aa9f6d06de4f92ead5b

PKG_BUILD_DIR:=$(BUILD_DIR)/zeroconf-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python3-setuptools

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

define Package/python3-zeroconf
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Pure Python Multicast DNS Service Discovery Library (Bonjour/Avahi compatible)
  URL:=https://github.com/jstasiak/python-zeroconf
  DEPENDS:=+python3 +python3-netifaces +python3-six
endef

define Package/python3-zeroconf/description
  Pure Python Multicast DNS Service Discovery Library (Bonjour/Avahi compatible)
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,, \
		install --root="$(PKG_INSTALL_DIR)" --prefix="/usr"  \
		--single-version-externally-managed \
	)
endef

$(eval $(call Py3Package,python3-zeroconf))
$(eval $(call BuildPackage,python3-zeroconf))
