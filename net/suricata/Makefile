
# Copyright (C) 2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=suricata
PKG_VERSION:=4.0.0
PKG_RELEASE=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://www.openinfosecfoundation.org/download/
PKG_MD5SUM:=41fb91b4cbc6705b353e4bdd02c3df4b

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf
PKG_BUILD_PARALLEL:=1
PKG_LICENSE:=GPL-2.0

include $(INCLUDE_DIR)/package.mk

CONFIGURE_ARGS+= \
	--enable-nflog \
	--enable-luajit \
	--enable-nfqueue \
	--disable-gccprotect \
	--enable-non-bundled-htp \
	--disable-gccmarch-native	

define Package/suricata
  SECTION:=net
  CATEGORY:=Network
  TITLE:=IDS
  DEPENDS:=+libpcre +libyaml +jansson +libmagic +libpthread +librt +libpcap +luajit +libnetfilter-queue +libnetfilter-log +libnfnetlink +libhtp
endef

define Package/suricata/conffiles
/etc/suricata/*
/etc/config/suricata
/etc/suricata/rules/*
endef

define Package/suricata/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/suricata.init $(1)/etc/init.d/suricata
	$(INSTALL_DIR) $(1)/etc/cron.d
	$(CP) ./files/suricata.cron $(1)/etc/cron.d/suricata
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/suricata* $(1)/usr/bin
	$(INSTALL_BIN) ./files/update_rules.sh $(1)/usr/bin/suricata_update_rules.sh
	$(INSTALL_DIR) $(1)/etc/suricata
	$(INSTALL_CONF) ./files/suricata.yaml $(1)/etc/suricata/suricata.yaml
	$(INSTALL_DIR) $(1)/etc/suricata/output_conf.d
	$(INSTALL_CONF) ./files/output_common.yaml $(1)/etc/suricata/output_conf.d/common.yaml
	$(INSTALL_DIR) $(1)/etc/config
	$(CP) ./files/suricata.config $(1)/etc/config/suricata
	$(CP) $(PKG_BUILD_DIR)/classification.config $(1)/etc/suricata
	$(CP) $(PKG_BUILD_DIR)/reference.config $(1)/etc/suricata
	$(CP) $(PKG_BUILD_DIR)/threshold.config $(1)/etc/suricata
	$(CP) $(PKG_BUILD_DIR)/rules $(1)/etc/suricata
endef

$(eval $(call BuildPackage,suricata))
