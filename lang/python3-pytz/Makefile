#
# Copyright (C) 2015 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python3-pytz
PKG_VERSION:=2015.4
PKG_RELEASE:=1

PKG_SOURCE:=pytz-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/p/pytz/
PKG_MD5SUM:=417a47b1c432d90333e42084a605d3d8

PKG_BUILD_DIR:=$(BUILD_DIR)/pytz-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python3-setuptools

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-pytz
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=World timezone definitions, modern and historical
  URL:=http://pythonhosted.org/pytz
  DEPENDS:=+python3
endef

define Package/python3-pytz/description
  World timezone definitions, modern and historical
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,, \
		install --root="$(PKG_INSTALL_DIR)" --prefix="/usr"  \
		--single-version-externally-managed \
	)
endef

$(eval $(call Py3Package,python3-pytz))
$(eval $(call BuildPackage,python3-pytz))
