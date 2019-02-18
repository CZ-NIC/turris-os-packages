#
# Copyright (C) 2015 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python3-requests
PKG_VERSION:=2.21.0
PKG_RELEASE:=1

PKG_SOURCE:=requests-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/r/requests/
PKG_MD5SUM:=1bcd0e0977c3f8db1848ba0e2b7ab904

PKG_BUILD_DIR:=$(BUILD_DIR)/requests-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python3-setuptools

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-requests
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Python HTTP for Humans.
  URL:=http://python-requests.org
  DEPENDS:=+python3
endef

define Package/python3-requests/description
  Python HTTP for Humans.
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,, \
		install --root="$(PKG_INSTALL_DIR)" --prefix="/usr"  \
		--single-version-externally-managed \
	)
endef

$(eval $(call Py3Package,python3-requests))
$(eval $(call BuildPackage,python3-requests))
