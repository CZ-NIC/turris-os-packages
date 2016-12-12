#
# Copyright (C) 2015 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-turris-gpio
PKG_VERSION:=0.1.1
PKG_RELEASE:=2
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENCE.txt

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/python-turris-gpio.git
ifeq ($(ARCH),armhf)
  PKG_SOURCE_VERSION:=c162ace4e3ee6bbdadde820466f50a50e29cce9e
endif
ifeq ($(ARCH),powerpc)
  PKG_SOURCE_VERSION:=$(PKG_VERSION)
endif
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/python-turris-gpio
  SECTION:=language-python
  CATEGORY:=Languages
  SUBMENU:=Python
  TITLE:=python-turris-gpio
  URL:=http://python.sourceforge.net/
  DEPENDS:=+python
  MAINTAINER:=Pavel Spirek <pavel.spirek@nic.cz>
endef

define Package/python-turris-gpio/description
 This package is a modified RPi.GPIO python library.
 It provides a class to control the GPIO on a Turris router.
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix=/usr --root=$(PKG_INSTALL_DIR))
endef

define Package/python-turris-gpio/install
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)
	$(CP) \
		$(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* \
		$(1)$(PYTHON_PKG_DIR)
endef

$(eval $(call BuildPackage,python-turris-gpio))
