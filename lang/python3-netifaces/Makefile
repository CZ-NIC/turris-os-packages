#
# Copyright (C) 2015 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python3-netifaces
PKG_VERSION:=0.10.4
PKG_RELEASE:=2

PKG_SOURCE:=netifaces-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/n/netifaces/
PKG_MD5SUM:=36da76e2cfadd24cc7510c2c0012eb1e

PKG_BUILD_DIR:=$(BUILD_DIR)/netifaces-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python3-setuptools

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

define Package/python3-netifaces
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Portable network interface information.
  URL:=https://bitbucket.org/al45tair/netifaces
  DEPENDS:=+python3
endef

define Package/python3-netifaces/description
  Portable network interface information.
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,, \
		install --root="$(PKG_INSTALL_DIR)" --prefix="/usr"  \
		--single-version-externally-managed \
	)
endef

$(eval $(call Py3Package,python3-netifaces))
$(eval $(call BuildPackage,python3-netifaces))
