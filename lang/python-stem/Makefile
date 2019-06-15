#
# Copyright (C) 2018-2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-stem
PKG_VERSION:=1.7.1
PKG_RELEASE:=1

PKG_SOURCE:=stem-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://files.pythonhosted.org/packages/source/s/stem
PKG_HASH:=c9eaf3116cb60c15995cbd3dec3a5cbc50e9bb6e062c4d6d42201e566f498ca2

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
  URL:=https://stem.torproject.org/
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
