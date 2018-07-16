#
# Copyright (C) 2017 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pakon
PKG_VERSION:=1.2
PKG_RELEASE:=8
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/pakon-light.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=826001ad83cebe6ef38685304077f7401aca2071
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_MAINTAINER:=Martin Petracek <martin.petracek@nic.cz>
PKG_LICENSE:=GPL-3.0

PKG_INSTALL:=0

include $(INCLUDE_DIR)/package.mk

define Package/pakon
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Collect traffic events from suricata IDS
	TITLE:=PArental KONtrol - light
	DEPENDS:=+suricata-pakon +xz +python3-light +python3-logging +python3-cachetools +python3-sqlite3 +sqlite3-cli +pakon-lists +ouidb +suricata-conntrack-flows
endef

define Package/$(PKG_NAME)/description
  Simple daemon that is able to collect events from suricata, store them locally to SQLite DB.
endef

define Build/Compile
  true
endef

define Build/Install
  true
endef

define Package/$(PKG_NAME)/conffiles
/etc/config/pakon
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/suricata-pakon/output_conf.d
	$(INSTALL_DATA) ./files/pakon-output.yaml $(1)/etc/suricata-pakon/output_conf.d/pakon.yaml
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/pakon-monitor-init $(1)/etc/init.d/pakon-monitor
	$(INSTALL_BIN) ./files/pakon-handler-init $(1)/etc/init.d/pakon-handler
	$(INSTALL_DIR) $(1)/etc/cron.d
	$(INSTALL_DATA) ./files/pakon-cron $(1)/etc/cron.d/pakon
	$(INSTALL_DIR) $(1)/usr/share/pakon-light/domains_replace
	$(INSTALL_DIR) $(1)/usr/share/pakon-light/domains_ignore
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/show.py $(1)/usr/bin/pakon-show
	$(INSTALL_DIR) $(1)/usr/libexec/pakon-light
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/monitor.py $(1)/usr/libexec/pakon-light/pakon-monitor.py
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/handler.py $(1)/usr/libexec/pakon-light/pakon-handler.py
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/archive.py $(1)/usr/libexec/pakon-light/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/create_db.py $(1)/usr/libexec/pakon-light/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/domains_reapply.py $(1)/usr/libexec/pakon-light/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/notify_new_device.sh $(1)/usr/libexec/pakon-light/
	$(INSTALL_BIN) ./files/backup_sqlite.sh $(1)/usr/libexec/pakon-light/
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/pakon-uci.example $(1)/etc/config/pakon
endef

define Package/pakon/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
        # migrate configuration
        ARCHIVE_KEEP=$(/sbin/uci -q get pakon.archive.keep)
        /sbin/uci -q get pakon.monitor.interface || mv /etc/config/pakon-opkg /etc/config/pakon
	[ "${ARCHIVE_KEEP}" ] && /sbin/uci set pakon.archive.keep="${ARCHIVE_KEEP}"
        /sbin/uci commit pakon
	#archivation changes - records with dest_ip "" shouldn't appear anymore
	[ -f /srv/pakon/pakon-archive.db ] && /usr/bin/sqlite3 /srv/pakon/pakon-archive.db 'UPDATE traffic SET dest_ip="unknown address" WHERE dest_ip LIKE "" AND app_hostname IS NULL'
        /etc/init.d/pakon-monitor enable
        /etc/init.d/pakon-monitor restart 2>/dev/null
        /etc/init.d/pakon-handler enable
        /etc/init.d/pakon-handler restart 2>/dev/null
	/etc/init.d/suricata-pakon restart 2>/dev/null
}
endef

define Package/pakon/prerm
#!/bin/sh
        /etc/init.d/pakon-monitor disable
        /etc/init.d/pakon-monitor stop
        /etc/init.d/pakon-handler disable
        /etc/init.d/pakon-handler stop
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
