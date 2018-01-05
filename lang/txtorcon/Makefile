#
# Copyright (C) 2018 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=txtorcon
PKG_VERSION:=0.19.3
PKG_RELEASE:=1
PKG_LICENSE:=MIT

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/meejah/txtorcon.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

PKG_BUILD_DEPENDS:=python-setuptools

define Package/$(PKG_NAME)
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	TITLE:=txtorcon
	URL:=https://github.com/meejah/txtorcon
	DEPENDS:=+python +twisted +python-ipaddress +zope-interface
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef

define Package/$(PKG_NAME)/description
 Twisted-based asynchronous Tor control protocol implementation.
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install -v --prefix="/usr" --root=$(PKG_INSTALL_DIR))
endef

$(eval $(call PyPackage,txtorcon))
$(eval $(call BuildPackage,txtorcon))
