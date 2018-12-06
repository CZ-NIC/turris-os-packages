#
# Copyright (C) 2017 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=suricata-monitor
PKG_VERSION:=1.0
PKG_RELEASE:=6

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_MAINTAINER:=Michal Hrusecky <michal.hrusecky@nic.cz>
PKG_LICENSE:=GPL-3.0

PKG_INSTALL:=0

include $(INCLUDE_DIR)/package.mk

define Package/suricata-monitor
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Collect events from suricata IDS
	TITLE:=Suricata monitor
	DEPENDS:=+suricata-pakon +python-bottle +python-sqlite3
endef

define Package/$(PKG_NAME)/description
  Simple daemon that is able to collect events from suricata, store them locally
  and eventually react on some.
endef

define Package/$(PKG_NAME)/conffiles
/etc/suricata-monitor/alert.tmpl
/etc/suricata-pakon/output_conf.d/monitor.yaml
/etc/config/suricata-monitor
endef

define Build/Compile
endef

define Build/Install
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/suricata-pakon/output_conf.d
	$(INSTALL_DATA) ./files/monitor-output.yaml $(1)/etc/suricata-pakon/output_conf.d/suricata-monitor.yaml
	$(INSTALL_DIR) $(1)/etc/suricata-monitor
	$(INSTALL_DATA) ./files/alert.tmpl $(1)/etc/suricata-monitor/alert.tmpl
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/monitor.py $(1)/usr/bin/suricata-monitor
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/monitor-init $(1)/etc/init.d/suricata-monitor
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/monitor-uci $(1)/etc/config/suricata-monitor
	$(INSTALL_DIR) $(1)/etc/cron.d/
	$(INSTALL_DATA) ./files/monitor-cron $(1)/etc/cron.d/suricata-monitor

endef

$(eval $(call BuildPackage,suricata-monitor))
