#
## Copyright (C) 2013 CZ.NIC z.s.p.o. <martin.strbacka@nic.cz>
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=ucollect
PKG_VERSION:=16
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=ssh://git@git.nic.cz/router/ucollect
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=e25e045328b501756350c5d58eabf8946eacf973
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
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS) NO_DOC=1 MAX_LOG_LEVEL:=LLOG_INFO RELEASE:=1
endef

define Package/ucollect/conffiles
/etc/config/ucollect
endef

define Package/ucollect/postinst
/etc/init.d/ucollect enable
/etc/init.d/ucollect restart
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
	$(INSTALL_DIR) $(1)/usr/share/ucollect/config
	$(CP) $(PKG_BUILD_DIR)/src/ucollect/main.cfg $(1)/usr/share/ucollect/config
endef

$(eval $(call BuildPackage,ucollect))
