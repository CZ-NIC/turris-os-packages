#
# Copyright (C) 2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python3-pyroute2
PKG_VERSION:=0.5.5
PKG_RELEASE:=1

PKG_SOURCE:=pyroute2-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://files.pythonhosted.org/packages/source/p/pyroute2
PKG_MD5SUM:=ad679a91d453fe8426c4076d0da3a67265e5ccfe641879d75c9bc7660d075dfa

PKG_BUILD_DIR:=$(BUILD_DIR)/pyroute2-$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

define Package/python3-pyroute2
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Python netlink library
  URL:=http://github.com/svinota/pyroute2
  DEPENDS:= \
          +python3 \
          +python3-setuptools
endef

define Package/python3-pyroute2/description
  Pyroute2 is a pure Python netlink library.
  The library was started as an RTNL protocol implementation,
  but now it supports many netlink protocols.
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,, install --root="$(PKG_INSTALL_DIR)" --prefix="/usr")
endef

$(eval $(call Py3Package,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_NAME)))
