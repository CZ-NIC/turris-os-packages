#
## Copyright (C) 2020-2021 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=base64c
PKG_VERSION:=0.2.1
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE:=base64c-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://gitlab.nic.cz/api/v4/projects/973/packages/generic/base64c/$(PKG_VERSION)
PKG_HASH:=ebc12ecdb66a9261ba3d5cd06e87588764ac53aea2c64bd4c226f13cc2bf77d4

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/autotools.mk

define Package/base64c
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=base64c
  URL:=https://gitlab.nic.cz/turris/base64c.git
endef

define Package/base64c/description
  Base64 encoding/decoding library for C
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/* $(1)/usr/include/

	$(INSTALL_DIR) $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/* $(1)/usr/lib/
endef

define Package/base64c/install
	$(INSTALL_DIR) $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libbase64c.so* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,base64c))
