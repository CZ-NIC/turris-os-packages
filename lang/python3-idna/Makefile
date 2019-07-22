#
# Copyright (C) 2015-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=idna
PKG_VERSION:=2.8
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/i/idna
PKG_HASH:=c357b3f628cf53ae2c4c05627ecc484553142ca23264e593d327bcde5e9c3407

PKG_BUILD_DEPENDS:=python3 python3-setuptools

PKG_MAINTAINER:=Jeffery To <jeffery.to@gmail.com>
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE.rst

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

define Package/python3-idna
	SECTION:=lang
	CATEGORY:=Languages
	SUBMENU:=Python
	TITLE:=python-idna
	URL:=https://github.com/kjd/idna
	DEPENDS:=+python3-light
	VARIANT:=python3
endef

define Package/python3-idna/description
  A library to support the Internationalised Domain Names in Applications
  (IDNA) protocol as specified in RFC 5891. This version of the protocol
  is often referred to as "IDNA2008" and can produce different results
  from the earlier standard from 2003.
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,,install --prefix=/usr --root=$(PKG_INSTALL_DIR))
endef

$(eval $(call Py3Package,python3-idna))
$(eval $(call BuildPackage,python3-idna))
