#
# Copyright (C) 2015 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python3-netdisco
PKG_VERSION:=0.3
PKG_RELEASE:=2

PKG_SOURCE:=netdisco-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/n/netdisco/
PKG_MD5SUM:=79db163e571425405a94dac0a956fcb5

PKG_BUILD_DIR:=$(BUILD_DIR)/netdisco-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python3-setuptools

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

define Package/python3-netdisco
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Discover devices on your local network
  URL:=http://github.com/balloob/netdisco
  DEPENDS:=+python3 +python3-requests +python3-zeroconf
endef

define Package/python3-netdisco/description
  Discover devices on your local network
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,, \
		install --root="$(PKG_INSTALL_DIR)" --prefix="/usr"  \
		--single-version-externally-managed \
	)
endef

$(eval $(call Py3Package,python3-netdisco))
$(eval $(call BuildPackage,python3-netdisco))
