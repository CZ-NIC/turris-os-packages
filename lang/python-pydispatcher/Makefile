#
# Copyright (C) 2015-2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-pydispatcher
PKG_VERSION:=2.0.5
PKG_RELEASE:=2

PKG_SOURCE:=PyDispatcher-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/P/PyDispatcher/
PKG_HASH:=5570069e1b1769af1fe481de6dd1d3a388492acddd2cdad7a3bde145615d5caf

PKG_BUILD_DIR:=$(BUILD_DIR)/PyDispatcher-$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=BSD-2-Clause
PKG_LICENSE_FILES:=license.txt

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-pydispatcher
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Multi-producer-multi-consumer signal dispatching mechanism
  URL:=http://pydispatcher.sourceforge.net
  DEPENDS:=+python3-light
  VARIANT:=python3
endef

define Package/python3-pydispatcher/description
  Multi-producer-multi-consumer signal dispatching mechanism
endef

$(eval $(call Py3Package,python3-pydispatcher))
$(eval $(call BuildPackage,python3-pydispatcher))
$(eval $(call BuildPackage,python3-pydispatcher-src))
