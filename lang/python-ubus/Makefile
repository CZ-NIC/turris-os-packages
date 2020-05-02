#
# Copyright (C) 2018-2020 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-ubus
PKG_VERSION:=0.1
PKG_RELEASE:=2

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=LGPLv2.1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/python-ubus.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)


include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-ubus
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Python3 ubus
  URL:=https://gitlab.labs.nic.cz/turris/python-ubus/
  DEPENDS:=+libubus +libblobmsg-json +python3-light
  VARIANT:=python3
endef

define Package/python3-ubus/description
  Python bindings for ubus.
endef

$(eval $(call Py3Package,python3-ubus))
$(eval $(call BuildPackage,python3-ubus))
$(eval $(call BuildPackage,python3-ubus-src))
