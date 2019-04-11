#
# Copyright (C) 2015-2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-sentry-sdk
PKG_VERSION:=0.7.10
PKG_RELEASE:=1

PKG_SOURCE:=sentry-sdk-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/s/sentry-sdk/
PKG_HASH:=ca2723556c102a1fabdf461b9a038d1d8631608c4d10085a7c06a0b590e79ad4

PKG_BUILD_DIR:=$(BUILD_DIR)/$(BUILD_VARIANT)-sentry-sdk-$(PKG_VERSION)

PKG_LICENSE:=BSD-2-Clause
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python-package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

PKG_UNPACK:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

define Package/python-sentry-sdk/Default
  SECTION:=lang
  CATEGORY:=Languages
  SUBMENU:=Python
  TITLE:=Python Sentry-Python is an SDK for Sentry
  URL:=https://sentry.io/for/python/
endef

define Package/python3-sentry-sdk
$(call Package/python-sentry-sdk/Default)
  DEPENDS+= \
      +PACKAGE_python3-sentry-sdk:python3-light python3-urllib3 python3-certifi
  VARIANT:=python3
endef

define Package/python-sentry-sdk/description
Python Sentry-Python is an SDK for Sentry
endef

define Package/python3-sentry-sdk/description
$(call Package/python-sentry-sdk/description)
.
(Variant for Python3)
endef

$(eval $(call Py3Package,python3-sentry-sdk))
$(eval $(call BuildPackage,python3-sentry-sdk))
$(eval $(call BuildPackage,python3-sentry-sdk-src))
