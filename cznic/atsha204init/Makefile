#
## Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=atsha204init
PKG_VERSION:=2
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/libatsha204.git
PKG_SOURCE_VERSION:=61e463d557692f2131f5fdaa8a55e0aedcc6b03a
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Robin Obůrka <robin.oburka@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+libopenssl +libunbound +unbound
endef

define Build/Compile
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS) NO_DOC=1 USE_LAYER=USE_LAYER_NI2C STATIC_LOCAL=1 VERBOSE=1 DEFAULT_NI2C_DEV_PATH=NI2C_DEV_PATH_REMOTE
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/chipinit $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/chiptest $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/chiptools $(1)/usr/bin/
endef


$(eval $(call BuildPackage,$(PKG_NAME)))
