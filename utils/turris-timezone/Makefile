#
# Copyright (C) 2021 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=turris-timezone
PKG_VERSION:=0.2.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-v$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/foris-controller/$(PKG_NAME)/-/archive/v$(PKG_VERSION)/
PKG_HASH:=53352352ed85c2c021bbdf93a86f62a732a73011d8e8ec28f3b5bc6a04a5b100
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/turris-timezone
  SECTION:=lang
  CATEGORY:=Languages
  SUBMENU:=Python
  TITLE:=Turris timezone
  URL:=https://gitlab.nic.cz/turris/foris-controller/turris-timezone/
  DEPENDS:=+python3-light
  VARIANT:=python3
endef

define Package/turris-timezone/description
  Due to missing /usr/share/zoneinfo on OpenWrt, this package should 
  provide some basic data extracted from /usr/share/zoneinfo of build machnine.
endef

$(eval $(call Py3Package,turris-timezone))
$(eval $(call BuildPackage,turris-timezone))
$(eval $(call BuildPackage,turris-timezone-src))
