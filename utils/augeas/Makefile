#
# Copyright (C) 2018 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#


include $(TOPDIR)/rules.mk

PKG_NAME:=augeas
PKG_VERSION:=1.11.0
PKG_RELEASE=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://download.augeas.net/
PKG_MD5SUM:=393ce8f4055af89cd4c20bf903eacbbd909cf427891f41b56dc2ba66243ea0b0
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1
PKG_LICENSE:=GPL-2.0
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/augeas
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=A configuration editing tool
  URL:=http://augeas.net
  DEPENDS:=+libxml2 +libreadline +libncurses
endef

define Package/augeas/description
  Augeas is a configuration editing tool.
  It parses configuration files in their native formats and transforms them into a tree.
  Configuration changes are made by manipulating this tree and saving it back into native config files.
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/* $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/* $(1)/usr/lib/
endef

define Package/augeas/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/* $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/* $(1)/usr/lib/pkgconfig/
	$(INSTALL_DIR) $(1)/usr/share/augeas/lenses/dist/tests
	$(CP) $(PKG_INSTALL_DIR)/usr/share/augeas/lenses/dist/* $(1)/usr/share/augeas/lenses/dist/
	$(CP) $(PKG_INSTALL_DIR)/usr/share/augeas/lenses/dist/tests/* $(1)/usr/share/augeas/lenses/dist/tests
endef

$(eval $(call BuildPackage,augeas))
