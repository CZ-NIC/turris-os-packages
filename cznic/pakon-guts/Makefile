#
## Copyright (C) 2017 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=pakon-guts
PKG_VERSION:=4.3
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/pakon-guts.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=305b98c2145bf63de5cb09f300fa20c2c73798c9
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Michal Vaner <michal.vaner@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
PKG_RELEASE:=4

include $(INCLUDE_DIR)/package.mk

define Package/pakon-guts
	TITLE:=pakon-guts
	DEPENDS:=+liblua +libnetfilter-queue +iptables-mod-nfqueue +libstdcpp +libpthread +librt
endef

ifdef CONFIG_USE_MUSL
MAKE_PARAMS:=HAVE_RECVMMSG=1
else
MAKE_PARAMS:=
endif

define Build/Compile
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS) NO_DOC=1 RELEASE=1 MAX_LOG_LEVEL=DBG VERBOSE=1 $(MAKE_PARAMS)
endef

define Package/pakon-guts/install
	$(INSTALL_DIR) $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lib/libpakond.so $(1)/usr/lib/

	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/pakond $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/openwrt/pakond_wrapper.sh $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/openwrt/pakon.init $(1)/etc/init.d/pakond

	$(INSTALL_DIR) $(1)/etc/firewall.d/with_reload
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/openwrt/pakon.fw $(1)/etc/firewall.d/with_reload/99_pakon.fw

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/src/openwrt/pakon.conf $(1)/etc/config/pakon
endef

define Package/pakon-guts/conffiles
/etc/config/pakon
endef

define Package/pakon-guts/postinst
#!/bin/sh
	/etc/init.d/pakond enable
	/etc/init.d/pakond start
endef

define Package/pakon-guts/prerm
#!/bin/sh
	/etc/init.d/pakond disable
	/etc/init.d/pakond stop
endef

$(eval $(call BuildPackage,pakon-guts))
