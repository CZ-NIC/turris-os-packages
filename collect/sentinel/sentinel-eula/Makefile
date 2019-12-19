#
## Copyright (C) 2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=sentinel-eula
PKG_VERSION:=1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/sentinel/eula.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE.md

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  TITLE:=$(PKG_NAME)
  URL:=https://gitlab.labs.nic.cz/turris/sentinel/eula
  DEPENDS:=
endef

define Package/$(PKG_NAME)/description
  Package containing EULAs for sentinel
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/share/sentinel-eula/
	$(CP) $(PKG_INSTALL_DIR)/usr/share/sentinel-eula/* $(1)/usr/share/sentinel-eula/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
