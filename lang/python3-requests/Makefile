#
# Copyright (C) 2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python3-requests
PKG_VERSION:=2.21.0
PKG_RELEASE:=1

PKG_MAINTAINER:=Josef Schlehofer <josef.schlehofer@nic.cz>, Alexandru Ardelean <ardeleanalex@gmail.com>
PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_CPE_ID:=cpe:/a:python-requests:requests

PKG_SOURCE:=requests-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/r/requests/
PKG_HASH:=502a824f31acdacb3a35b6690b5fbf0bc41d63a24a45c4004352b0242707598e

PKG_BUILD_DIR:=$(BUILD_DIR)/requests3-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python3-setuptools

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

PKG_UNPACK:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

define Package/python3-requests
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Python HTTP for Humans
  URL:=http://python-requests.org
  DEPENDS:= \
	  +python3 \
	  +python3-chardet \
	  +python3-idna \
	  +python3-urllib3 \
	  +python3-certifi
endef

define Package/python3-requests/description
  Requests is the only Non-GMO HTTP library for Python, safe for human consumption
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,, \
		install --root="$(PKG_INSTALL_DIR)" --prefix="/usr"  \
		--single-version-externally-managed \
	)
endef

$(eval $(call Py3Package,python3-requests))
$(eval $(call BuildPackage,python3-requests))
