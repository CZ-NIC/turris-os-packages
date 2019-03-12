#
# Copyright (C) 2015 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python3-markdown
PKG_VERSION:=2.6.11
PKG_RELEASE:=1

PKG_SOURCE:=Markdown-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/m/markdown/
PKG_MD5SUM:=a67c1b2914f7d74eeede2ebe0fdae470

PKG_BUILD_DIR:=$(BUILD_DIR)/Markdown-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python3-setuptools

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

define Package/$(PKG_NAME)
  TITLE:=Markdown implementation in Python
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  DEPENDS:=+python3-light
endef

define Package/$(PKG_NAME)/description
  A fast and complete Python implementation of Markdown.
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,,install --root="$(PKG_INSTALL_DIR)" --prefix="/usr")
endef

$(eval $(call Py3Package,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_NAME)))
