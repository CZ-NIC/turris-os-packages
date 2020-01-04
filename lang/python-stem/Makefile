#
# Copyright (C) 2018-2020 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-stem
PKG_VERSION:=1.8.0
PKG_RELEASE:=1

PKG_SOURCE:=stem-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://files.pythonhosted.org/packages/source/s/stem
PKG_HASH:=a0b48ea6224e95f22aa34c0bc3415f0eb4667ddeae3dfb5e32a6920c185568c2

PKG_BUILD_DIR:=$(BUILD_DIR)/stem-$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=LGPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-stem
  SECTION:=lang
  CATEGORY:=Languages
  SUBMENU:=Python
  TITLE:=Controller library to interact with Tor
  URL:=https://github.com/torproject/stem/
  DEPENDS:=+python3-light
  VARIANT:=python3
endef

define Package/python3-stem/description
  Stem is a Python controller library that allows applications to interact with Tor (https://www.torproject.org/).
endef

PYTHON3_PKG_SETUP_ARGS:=

$(eval $(call Py3Package,python3-stem))
$(eval $(call BuildPackage,python3-stem))
$(eval $(call BuildPackage,python3-stem-src))
