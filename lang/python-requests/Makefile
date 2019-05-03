#
# Copyright (C) 2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-requests
PKG_VERSION:=2.21.0
PKG_RELEASE:=1

PKG_MAINTAINER:=Josef Schlehofer <josef.schlehofer@nic.cz>, Alexandru Ardelean <ardeleanalex@gmail.com>
PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_CPE_ID:=cpe:/a:python-requests:requests

PKG_SOURCE:=requests-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://files.pythonhosted.org/packages/source/r/requests
PKG_HASH:=502a824f31acdacb3a35b6690b5fbf0bc41d63a24a45c4004352b0242707598e

PKG_CPE_ID:=cpe:/a:python-requests:requests

PKG_BUILD_DIR:=$(BUILD_DIR)/requests-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python-setuptools

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/python-requests
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Python HTTP for Humans.
  URL:=http://python-requests.org
  DEPENDS:= \
	  +python \
	  +python-chardet \
	  +python-idna \
	  +python-urllib3 \
	  +python-certifi
endef

define Package/python-requests/description
  Requests is the only Non-GMO HTTP library for Python, safe for human consumption
endef

define Build/Compile
	$(call Build/Compile/PyMod,, \
		install --root="$(PKG_INSTALL_DIR)" --prefix="/usr"  \
		--single-version-externally-managed \
	)
endef

$(eval $(call PyPackage,python-requests))
$(eval $(call BuildPackage,python-requests))
