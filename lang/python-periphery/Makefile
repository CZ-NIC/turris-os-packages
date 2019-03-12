#
# Copyright (C) 2017 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-periphery
PKG_VERSION:=v1.1.1
PKG_RELEASE:=1
PKG_LICENSE:=MIT

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/vsergeev/python-periphery.git
PKG_SOURCE_VERSION:=$(PKG_VERSION)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/$(PKG_NAME)
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	TITLE:=python-periphery
	URL:=https://github.com/vsergeev/python-periphery
	DEPENDS:=+python
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef

define Package/$(PKG_NAME)/description
 python-periphery is a pure Python library for GPIO, LED, PWM, SPI, I2C, MMIO, and
 Serial peripheral I/O interface access in userspace Linux.
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix="/usr" --root=$(PKG_INSTALL_DIR))
endef

$(eval $(call PyPackage,python-periphery))
$(eval $(call BuildPackage,python-periphery))
