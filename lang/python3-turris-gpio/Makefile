#
# Copyright (C) 2017 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python3-turris-gpio
PKG_VERSION:=0.1.2
PKG_RELEASE:=2
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENCE.txt

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/python-turris-gpio.git
PKG_SOURCE_VERSION:=$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

define Package/python3-turris-gpio
  SECTION:=language-python
  CATEGORY:=Languages
  SUBMENU:=Python
  TITLE:=python3-turris-gpio
  URL:=http://python.sourceforge.net/
  DEPENDS:=+python3
  MAINTAINER:=Tomas Hlavacek <tomas.hlavacek@nic.cz>
endef

define Package/python-turris-gpio/description
 This package is a modified RPi.GPIO python library.
 It provides a class to control the GPIO on a Turris router.
endef

ifeq ($(CONFIG_TARGET_mpc85xx_p2020_nand_TURRISNAND),y)
define Build/Compile
	$(call Build/Compile/Py3Mod,,install --prefix=/usr --root=$(PKG_INSTALL_DIR))
endef
endif

ifeq ($(CONFIG_TARGET_mvebu_Turris-Omnia),y)
define Build/Compile
	$(call Build/Compile/Py3Mod,,install --board=Omnia --prefix=/usr --root=$(PKG_INSTALL_DIR))
endef
endif

$(eval $(call Py3Package,python3-turris-gpio))
$(eval $(call BuildPackage,python3-turris-gpio))
