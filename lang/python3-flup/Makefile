#
# Copyright (C) 2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=flup
PKG_VERSION:=1.0.3
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/f/flup/
PKG_MD5SUM:=a64e7a6374e043480ee92534c735964e

PKG_LICENSE:=BSD
PKG_LICENSE_FILES:PKG-INFO

PKG_BUILD_DIR:=$(BUILD_DIR)/$(BUILD_VARIANT)-$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python python3

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

PKG_UNPACK:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

define Package/python3-flup
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	URL:=http://pypi.python.org/pypi/flup/
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
	TITLE:=python3-flup
	DEPENDS:=+python3-light +python3-logging
	VARIANT:=python3
endef

define Package/python3-flup/description
  Random assortment of WSGI servers
endef

$(eval $(call Py3Package,python3-flup))
$(eval $(call BuildPackage,python3-flup))
$(eval $(call BuildPackage,python3-flup-src))
