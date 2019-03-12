#
# Copyright (C) 2018 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python3-augeas
PKG_VERSION:=1.0.3
PKG_RELEASE:=1

PKG_SOURCE:=python-augeas-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://files.pythonhosted.org/packages/b4/d7/62d335d9df28e2f78207dcd12bbbcee89a7b5ba6d247feaddc9d04f27e1e/
PKG_MD5SUM:=d062f4a44aee797aa9296f5a82cd8c3df5036ca23df6b9ac48cbaa3b4f29a664

PKG_BUILD_DIR:=$(BUILD_DIR)/python-augeas-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python python3 augeas

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

define Package/$(PKG_NAME)
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=python3-augeas
  URL:=http://augeas.net
  DEPENDS:=+python3 +python3-cffi +augeas
  MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef

define Package/$(PKG_NAME)/description
  Python binding to Augeas library
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,,install --prefix="/usr" --root=$(PKG_INSTALL_DIR))
endef

$(eval $(call Py3Package,python3-augeas))
$(eval $(call BuildPackage,python3-augeas))
