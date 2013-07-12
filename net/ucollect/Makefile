#
## Copyright (C) 2013 CZ.NIC z.s.p.o. <martin.strbacka@nic.cz>
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=ucollect
PKG_VERSION:=12
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=ssh://git@git.nic.cz/router/ucollect
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=91bb10a6e131fc15e258512b872704a46a04534c
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Martin Strbacka <martin.strbacka@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/ucollect
	SECTION:=net
	CATEGORY:=Network
	DEFAULT:=y
	TITLE:=Netflow data collecting daemon
	DEPENDS:=+libpcap +librt +libopenssl +libuci
endef

define Build/Compile
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS) NO_DOC=1 MAX_LOG_LEVEL:=LOG_DEBUG RELEASE:=1
endef

define Package/ucollect/conffiles
/etc/config/ucollect
endef

define Package/ucollect/install
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/ucollect $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/ucollect.init $(1)/etc/init.d/ucollect
	$(INSTALL_DIR) $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lib/libplugin_buckets.so $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lib/libplugin_count.so $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lib/libucollect_core.so $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/src/ucollect/ucollect.cfg $(1)/etc/config/ucollect
endef

$(eval $(call BuildPackage,ucollect))
