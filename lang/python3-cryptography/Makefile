#
# Copyright (C) 2015-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=cryptography
PKG_VERSION:=1.3.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/c/cryptography
PKG_MD5SUM:=bc8148d2ff2d80fef8ef2d2e856b3a7f

PKG_BUILD_DEPENDS:=python3-cffi/host

PKG_LICENSE:=Apache-2.0 BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE.APACHE LICENSE.BSD
PKG_MAINTAINER:=Jeffery To <jeffery.to@gmail.com>

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

define Package/python3-cryptography
	SECTION:=lang
	CATEGORY:=Languages
	SUBMENU:=Python
	TITLE:=python3-cryptography
	URL:=https://github.com/pyca/cryptography
	DEPENDS:=+libopenssl +python3 +python3-cffi +python3-idna +python3-pyasn1 +python3-six +python3-setuptools
endef

define Package/python3-cryptography/description
cryptography is a package which provides cryptographic recipes and
primitives to Python developers.  Our goal is for it to be your "cryptographic
standard library". It supports Python 2.6-2.7, Python 3.3+, and PyPy 2.6+.
endef

define PyPackage/python3-cryptography/filespec
+|$(PYTHON_PKG_DIR)
-|$(PYTHON_PKG_DIR)/cryptography/hazmat/backends/commoncrypto
-|$(PYTHON_PKG_DIR)/cryptography/hazmat/bindings/commoncrypto
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,,install --prefix="/usr" --root="$(PKG_INSTALL_DIR)")
endef

$(eval $(call Py3Package,python3-cryptography))
$(eval $(call BuildPackage,python3-cryptography))
