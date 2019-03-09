#
# Copyright (C) 2017-2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-usb
PKG_VERSION:=1.0.2
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/walac/pyusb.git
PKG_SOURCE_VERSION:=$(PKG_VERSION)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-usb
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=python3-usb
  URL:=http://walac.github.io/pyusb/
  MAINTAINER:=CZ.NIC <packaging@turris.cz>
  DEPENDS:=+python3-light +libusb-1.0
  VARIANT:=python3
endef

define Package/python3-usb/description
  The PyUSB module provides for Python easy access to the host machine's Universal
  Serial Bus (USB) system.
endef

$(eval $(call Py3Package,python3-usb))
$(eval $(call BuildPackage,python3-usb))
