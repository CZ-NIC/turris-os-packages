#
# Copyright (C) 2015 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python3-astral
PKG_VERSION:=0.8.1
PKG_RELEASE:=2

PKG_SOURCE:=astral-$(PKG_VERSION).zip
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/a/astral/
PKG_MD5SUM:=f5add6f37c4f8233e1e42c1ee4232963

PKG_BUILD_DIR:=$(BUILD_DIR)/astral-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python3-setuptools

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

define Package/python3-astral
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Calculations for the position of the sun and moon.
  URL:=https://launchpad.net/astral
  DEPENDS:=+python3 +python3-pytz
endef

define Package/python3-astral/description
  Calculations for the position of the sun and moon.
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,, \
		install --root="$(PKG_INSTALL_DIR)" --prefix="/usr"  \
		--single-version-externally-managed \
	)
endef

$(eval $(call Py3Package,python3-astral))
$(eval $(call BuildPackage,python3-astral))
