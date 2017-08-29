#
# Copyright (C) 2017 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-client
PKG_VERSION:=0.2.1
PKG_RELEASE:=1
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/foris-client
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
PKG_LICENSE:=GPL-3.0

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)


define Package/foris-client
	TITLE:=foris-client
	URL:=https://gitlab.labs.nic.cz/turris/foris-client
	DEPENDS:=+foris-controller
	MAINTAINER:=Stepan Henek <stepan.henek@nic.cz>
endef

define Package/foris-client/description
	An program/library which is act as a client of foris-controller.
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix=/usr --root=$(PKG_INSTALL_DIR))
endef

define Package/foris-client/conffiles
endef

define Package/foris-client/install
	$(INSTALL_DIR) $(1)
	$(CP) $(PKG_INSTALL_DIR)/* $(1)/
endef


$(eval $(call BuildPackage,foris-client))
