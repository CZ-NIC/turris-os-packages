
# Copyright (C) 2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=suricata-bin
PKG_VERSION:=4.0.7
PKG_RELEASE=2

PKG_SOURCE:=suricata-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://www.openinfosecfoundation.org/download/
PKG_HASH:=8a0e6791cf1663b2b64bf16b83a9325125d533cf7784b49dd93593627cf23dec

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_CPE_ID:=cpe:/a:suricata-ids:suricata

PKG_BUILD_DIR:=$(BUILD_DIR)/suricata-$(PKG_VERSION)

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

CONFIGURE_ARGS+= \
	--enable-nflog \
	--enable-nfqueue \
	--disable-libmagic \
	--disable-gccprotect \
	--enable-non-bundled-htp \
	--disable-gccmarch-native

ifeq (,$(filter $(CONFIG_PACKAGE_luajit),y m))
CONFIGURE_ARGS+= --disable-luajit
LUAJIT_DEP:=
else
CONFIGURE_ARGS+= --enable-luajit
LUAJIT_DEP:=+luajit
endif

define Package/suricata-bin
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Network IDS, IPS and NSM engine
  URL:=https://suricata-ids.org/
  DEPENDS:=+libpcre +libyaml +jansson +libmagic +libpthread +librt +libpcap $(LUAJIT_DEP) +libnetfilter-queue +iptables-mod-nfqueue +libnetfilter-log +libnfnetlink +iptables-mod-conntrack-extra +libhtp +libnet-1.2.x
endef

define Package/suricata-rules
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Rules files for Suricata
  URL:=https://suricata-ids.org/
  DEPENDS:=+suricata-bin
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

define Package/suricata-rules/install
	$(INSTALL_DIR) $(1)/etc/suricata/rules
	$(CP) $(PKG_BUILD_DIR)/rules/*.rules $(1)/etc/suricata/rules
endef

$(eval $(call BuildPackage,suricata-bin))
$(eval $(call BuildPackage,suricata-rules))
