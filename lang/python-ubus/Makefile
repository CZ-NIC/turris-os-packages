#
# Copyright (C) 2018 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-ubus
PKG_VERSION:=0.1
PKG_RELEASE:=1
PKG_LICENSE:=LGPLv2.1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/python-ubus.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz

PKG_BUILD_DIR:=$(BUILD_DIR)/$(BUILD_VARIANT)-$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python-package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

PKG_UNPACK:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

TARGET_CFLAGS += --std=gnu99

define Package/python-ubus/Default
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  URL:=https://gitlab.labs.nic.cz/turris/python-ubus/
  MAINTAINER:=CZ.NIC <packaging@turris.cz>
  DEPENDS:=+libubus +libblobmsg-json
endef

define Package/python-ubus
  $(call Package/python-ubus/Default)
  TITLE:=python-ubus
  DEPENDS+=+PACKAGE_python-ubus:python-light
  VARIANT:=python
endef

define Package/python3-ubus
  $(call Package/python-ubus/Default)
  TITLE:=python3-ubus
  DEPENDS+=+PACKAGE_python3-ubus:python3-light
  VARIANT:=python3
endef

define Package/python-ubus/description
  Python bindings for ubus.
endef

define Package/python3-ubus/description
  $(call Package/python-ubus/description)
  .
  (Variant for Python3)
endef

$(eval $(call PyPackage,python-ubus))
$(eval $(call BuildPackage,python-ubus))

$(eval $(call Py3Package,python3-ubus))
$(eval $(call BuildPackage,python3-ubus))
