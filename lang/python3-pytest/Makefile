#
# Copyright (C) 2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python3-pytest
PKG_RELEASE:=1
PKG_VERSION:=4.0.2
PKG_SOURCE_URL:=https://files.pythonhosted.org/packages/9d/a9/3688b67467527c25e7a4d02c3b22565f15158a0a5d681870bfda8af210c6
PKG_MD5SUM:=f689bf2fc18c4585403348dd56f47d87780bf217c53ed9ae7a3e2d7faa45f8e9
PKG_SOURCE:=pytest-$(PKG_VERSION).tar.gz
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_BUILD_DIR:=$(BUILD_DIR)/pytest-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

define Package/python3-pytest
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	TITLE:=pytest
	URL:=https://docs.pytest.org/en/latest/
	DEPENDS:=+python3
endef

define Package/python3-pytest/description
   The pytest framework makes it easy to write small tests, yet scales to support complex functional testing for applications and libraries.
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,,\
		install --prefix="$(PKG_INSTALL_DIR)/usr" \
	)
endef



define Py3Package/python3-pytest/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/pytest.py $(1)/usr/bin/
	$(LN) /usr/bin/pytest.py $(1)/usr/bin/pytest
endef

$(eval $(call Py3Package,python3-pytest))
$(eval $(call BuildPackage,python3-pytest))
