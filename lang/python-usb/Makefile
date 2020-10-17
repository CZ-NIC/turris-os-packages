#
# Copyright (C) 2017-2020 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-usb
PKG_VERSION:=1.1.0
PKG_RELEASE:=1

PYPI_NAME:=pyusb
PKG_HASH:=d69ed64bff0e2102da11b3f49567256867853b861178689671a163d30865c298

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE

include $(TOPDIR)/feeds/packages/lang/python/pypi.mk
include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-usb
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=USB access for Python
  URL:=https://pyusb.github.io/pyusb/
  DEPENDS:=+python3-light +libusb-1.0
  VARIANT:=python3
endef

define Package/python3-usb/description
  The PyUSB module provides for Python easy access to the host machine's Universal
  Serial Bus (USB) system.
endef

$(eval $(call Py3Package,python3-usb))
$(eval $(call BuildPackage,python3-usb))
$(eval $(call BuildPackage,python3-usb-src))
