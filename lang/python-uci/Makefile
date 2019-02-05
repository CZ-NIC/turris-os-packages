#
# Copyright (C) 2018 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-uci
PKG_VERSION:=0.4.1
PKG_RELEASE:=1
PKG_LICENSE:=GPLv3

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/pyuci.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python-setuptools python3-setuptools

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)
$(call include_mk, python3-package.mk)

define Package/Common
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  URL:=https://gitlab.labs.nic.cz/turris/pyuci/
  MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef

define Package/python-uci
  $(call Package/Common)
  TITLE:=python-uci
  DEPENDS:=+python-light +libuci
endef

define Package/python3-uci
  $(call Package/Common)
  TITLE:=python3-uci
  DEPENDS:=+python3-light +libuci
endef

define Package/$(PKG_NAME)/description
  Python bindings for Unified Configuration Interface.
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix="/usr" --root=$(PKG_INSTALL_DIR)/py2)
	$(call Build/Compile/Py3Mod,,install --prefix="/usr" --root=$(PKG_INSTALL_DIR)/py3)
endef

PKG_INSTALL_DIR_ORIG:="$(PKG_INSTALL_DIR)"
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)/py2"
$(eval $(call PyPackage,python-uci))
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)/py3"
$(eval $(call Py3Package,python3-uci))
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)"

$(eval $(call BuildPackage,python-uci))
$(eval $(call BuildPackage,python3-uci))
