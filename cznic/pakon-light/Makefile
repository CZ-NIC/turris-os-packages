#
# Copyright (C) 2017 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pakon-light
PKG_VERSION:=1.0
PKG_RELEASE:=1
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/pakon-light.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=737fb33fe0d34a3e10eaf1dbc3bdc9150cb95688
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_MAINTAINER:=Martin Petracek <martin.petracek@nic.cz>
PKG_LICENSE:=GPL-3.0

PKG_INSTALL:=0

include $(INCLUDE_DIR)/package.mk

define Package/pakon-light
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Collect traffic events from suricata IDS
	TITLE:=PArental KONtrol - light
	DEPENDS:=+suricata +python-sqlite3
endef

define Package/$(PKG_NAME)/description
  Simple daemon that is able to collect events from suricata, store them locally to SQLite DB.
endef

define Package/$(PKG_NAME)/conffiles
endef

define Build/Compile
  true
endef

define Build/Install
  true
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/suricata/output_conf.d
	$(INSTALL_DATA) ./files/pakon-output.yaml $(1)/etc/suricata/output_conf.d/pakon.yaml
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/pakon-init $(1)/etc/init.d/pakon
	$(INSTALL_DIR) $(1)/etc/cron.d
	$(INSTALL_DATA) ./files/pakon-cron $(1)/etc/cron.d/pakon
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/monitor.py $(1)/usr/bin/pakon-monitor
	$(INSTALL_DIR) $(1)/usr/libexec/pakon-light
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/fill_dns.py $(1)/usr/libexec/pakon-light/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/group_services.py $(1)/usr/libexec/pakon-light/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/monitor.py $(1)/usr/libexec/pakon-light/
endef

$(eval $(call BuildPackage,pakon-light))
