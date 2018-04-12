
# Copyright (C) 2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=suricata-bin
PKG_VERSION:=4.0.3
PKG_RELEASE=2

PKG_SOURCE:=suricata-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://www.openinfosecfoundation.org/download/
PKG_MD5SUM:=8ab68a083a8c20ffab2a9fd03872443f
PKG_BUILD_DIR:=$(BUILD_DIR)/suricata-$(PKG_VERSION)

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf
PKG_BUILD_PARALLEL:=1
PKG_LICENSE:=GPL-2.0

include $(INCLUDE_DIR)/package.mk

CONFIGURE_ARGS+= \
	--enable-nflog \
	--enable-luajit \
	--enable-nfqueue \
        --disable-libmagic \
	--disable-gccprotect \
	--enable-non-bundled-htp \
	--disable-gccmarch-native	

define Package/suricata-bin
  SECTION:=net
  CATEGORY:=Network
  TITLE:=IDS
  DEPENDS:=+libpcre +libyaml +jansson +libmagic +libpthread +librt +libpcap +luajit +libnetfilter-queue +iptables-mod-nfqueue +libnetfilter-log +libnfnetlink +iptables-mod-conntrack-extra +libhtp +libnet-1.2.x
endef

define Package/suricata-bin/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/suricata* $(1)/usr/bin
	$(INSTALL_DIR) $(1)/etc/suricata
	$(CP) $(PKG_BUILD_DIR)/suricata.yaml $(1)/etc/suricata
	$(CP) $(PKG_BUILD_DIR)/classification.config $(1)/etc/suricata
	$(CP) $(PKG_BUILD_DIR)/reference.config $(1)/etc/suricata
	$(CP) $(PKG_BUILD_DIR)/threshold.config $(1)/etc/suricata
endef

$(eval $(call BuildPackage,suricata-bin))
