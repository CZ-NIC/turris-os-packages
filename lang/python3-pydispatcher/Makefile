#
# Copyright (C) 2015 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python3-pydispatcher
PKG_VERSION:=2.0.5
PKG_RELEASE:=2

PKG_SOURCE:=PyDispatcher-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/P/PyDispatcher/
PKG_MD5SUM:=1b9c2ca33580c2770577add7130b0b28

PKG_BUILD_DIR:=$(BUILD_DIR)/PyDispatcher-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python3-setuptools

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

define Package/python3-pydispatcher
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Multi-producer-multi-consumer signal dispatching mechanism
  URL:=http://pydispatcher.sourceforge.net
  DEPENDS:=+python3
endef

define Package/python3-pydispatcher/description
  Multi-producer-multi-consumer signal dispatching mechanism
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,, \
		install --root="$(PKG_INSTALL_DIR)" --prefix="/usr"  \
		--single-version-externally-managed \
	)
endef

$(eval $(call Py3Package,python3-pydispatcher))
$(eval $(call BuildPackage,python3-pydispatcher))
