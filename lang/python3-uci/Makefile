#
# Copyright (C) 2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python3-uci
PKG_VERSION:=0.6.1
PKG_RELEASE:=1
PKG_LICENSE:=GPLv3

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/pyuci.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python3-setuptools

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

define Package/python3-uci
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=python3-uci
  DEPENDS:=+python3-light +libuci
  URL:=https://gitlab.labs.nic.cz/turris/pyuci/
  MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef

define Package/python3-uci/description
  Python3 bindings for Unified Configuration Interface.
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,,install --prefix="/usr" --root=$(PKG_INSTALL_DIR))
endef

$(eval $(call Py3Package,python3-uci))
$(eval $(call BuildPackage,python3-uci))
