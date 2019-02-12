#
# Copyright (C) 2017-2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-periphery
PKG_VERSION:=1.1.1
PKG_RELEASE:=1
PKG_LICENSE:=MIT

PKG_SOURCE:=v$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/vsergeev/python-periphery/archive/
PKG_HASH:=a9a0a0ac02b8c3a954281777e92a15ec41abd311eb8732b50a2faaa9df62f1df

PKG_BUILD_DIR:=$(BUILD_DIR)/$(BUILD_VARIANT)-periphery-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python-package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

PKG_UNPACK:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

define Package/$(PKG_NAME)/Default
	SECTION:=lang-python
	CATEGORY:=Languages
	SUBMENU:=Python
	URL:=https://github.com/vsergeev/python-periphery
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef

define Package/python-periphery
$(call Package/python-periphery/Default)
	TITLE:=python-periphery
	DEPENDS:=+python-light
	VARIANT:=python
endef

define Package/python3-periphery
$(call Package/python-periphery/Default)
	TITLE:=python3-periphery
	DEPENDS:=+python3-light
	VARIANT:=python3
endef

define Package/python-periphery/description
 python-periphery is a pure Python library for GPIO, LED, PWM, SPI, I2C, MMIO, and
 Serial peripheral I/O interface access in userspace Linux.
endef

define Package/python3-periphery/description
$(call Package/python-periphery/description)
.
(Variant for Python3)
endef

$(eval $(call PyPackage,python-periphery))
$(eval $(call BuildPackage,python-periphery))
$(eval $(call Py3Package,python3-periphery))
$(eval $(call BuildPackage,python3-periphery))
