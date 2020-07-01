#
# Copyright (C) 2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-atsha204
PKG_VERSION:=29.2
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/libatsha204.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)


PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-atsha204
  SECTION:=lang
  CATEGORY:=Languages
  SUBMENU:=Python
  TITLE:=atsha204 access
  URL:=https://gitlab.nic.cz/turris/libatsha204
  DEPENDS:=+python3-light +libatsha204
  PROVIDES:=python3-libatsha204
  VARIANT:=python3
endef

PYTHON3_PKG_SETUP_DIR:=/src/python
PYTHON3_PKG_SETUP_ARGS:=

define Package/python3-atsha204/description
  Python3 bindings for libatsha204.
endef

$(eval $(call Py3Package,python3-atsha204))
$(eval $(call BuildPackage,python3-atsha204))
$(eval $(call BuildPackage,python3-atsha204-src))
