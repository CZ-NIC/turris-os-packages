#
# Copyright (C) 2018-2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-uci
PKG_VERSION:=0.6
PKG_RELEASE:=1
PKG_LICENSE:=GPLv3

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/pyuci.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-uci
  TITLE:=python3-uci
  SECTION:=lang-python
  CATEGORY:=Languages
  SUBMENU:=Python
  URL:=https://gitlab.labs.nic.cz/turris/pyuci/
  MAINTAINER:=CZ.NIC <packaging@turris.cz>
  DEPENDS:=+python3-light +libuci
  VARIANT:=python3
endef

define Package/python3-uci/description
Python3 bindings for Unified Configuration Interface.
endef

$(eval $(call Py3Package,python3-uci))
$(eval $(call BuildPackage,python3-uci))
