#
## Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-firewall-rules
PKG_VERSION:=1
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=ssh://git@git.nic.cz/router/fw-rules.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=6d78579a14cf0b12aaf202eda9940a111d5ea997
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Stepan Henek <stepan.henek@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+firewall
endef

define Build/Compile
endef

#define Package/$(PKG_NAME)/conffiles
#/etc/config/firewall
#endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/share/firewall
	$(CP) $(PKG_BUILD_DIR)/firewall.turris $(1)/usr/share/firewall/turris
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
