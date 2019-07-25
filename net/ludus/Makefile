#
# Copyright (C) 2019 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
#
include $(TOPDIR)/rules.mk

PKG_NAME:=ludus
PKG_VERSION:=0.8
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/stratosphereips/Ludus.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=20ab147a4f112a331d786cb22f3deeef5e12382d

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-only
PKG_LICENSE_FILES:=LICENSE

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/ludus
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Ludus
  URL:=https://github.com/stratosphereips/Ludus/
  DEPENDS:= \
    +python3-light \
    +suricata-bin \
    +python3-msgpack \
    +python3-simplejson \
    +suricata-bin \
    +haas-proxy \
    +kmod-ipt-tarpit \
    +iptables-mod-tarpit \
    +suricata-emergingthreats-rules-ludus \
    +python3-zmq \
    +sentinel-proxy \
    +sentinel-minipot \
    +suricata-rules
endef


define Package/ludus/description
  The Ludus system is a group of tools used for gathering information about the
  network in routers and applying the defence strategy gained from the Game Theory model.
endef

define Package/ludus/conffiles
/etc/config/ludus
endef

define Build/Compile
	true
endef

define Build/Install
	true
endef

define Package/ludus/postinst
	true
endef

define Package/ludus/install
	$(INSTALL_DIR) $(1)/usr/share/ludus
	$(CP) $(PKG_BUILD_DIR)/IPTablesAnalyzer $(1)/usr/share/ludus/
	$(CP) $(PKG_BUILD_DIR)/Strategizer $(1)/usr/share/ludus/
	$(CP) $(PKG_BUILD_DIR)/Suricata_Extractor $(1)/usr/share/ludus/
	$(CP) $(PKG_BUILD_DIR)/IPTablesAnalyzer $(1)/usr/share/ludus/
	$(CP) $(PKG_BUILD_DIR)/LICENSE $(1)/usr/share/ludus/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/{ludus.py,install.py} $(1)/usr/share/ludus/
	$(INSTALL_DIR) $(1)/etc/ludus
	$(CP) ./files/ludus_template.conf $(1)/etc/ludus/
	$(INSTALL_DIR) $(1)/etc/ludus/strategy
	$(CP) $(PKG_BUILD_DIR)/Strategizer/strategies/* $(1)/etc/ludus/strategy/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/ludus.init $(1)/etc/init.d/ludus
	$(INSTALL_DIR) $(1)/etc/config
	$(CP) ./files/ludus.conf $(1)/etc/config/ludus
endef

$(eval $(call BuildPackage,ludus))
