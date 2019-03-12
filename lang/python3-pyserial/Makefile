#
# Copyright (C) 2015 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python3-pyserial
PKG_VERSION:=2.7
PKG_RELEASE:=2

PKG_SOURCE:=pyserial-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/p/pyserial/
PKG_MD5SUM:=794506184df83ef2290de0d18803dd11

PKG_BUILD_DIR:=$(BUILD_DIR)/pyserial-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

define Package/python3-pyserial
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Python Serial Port Extension
  URL:=http://pyserial.sourceforge.net/
  DEPENDS:=+python3
endef

define Package/python3-pyserial/description
  Python Serial Port Extension
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,, \
		install --root="$(PKG_INSTALL_DIR)" --prefix="/usr"  \
	)
endef

$(eval $(call Py3Package,python3-pyserial))
$(eval $(call BuildPackage,python3-pyserial))
