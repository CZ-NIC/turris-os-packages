#
# Copyright (C) 2017-2020 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pakon
PKG_VERSION:=1.2.1
PKG_RELEASE:=3

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/pakon.git
PKG_MIRROR_HASH:=19ab1643d0133b6324eda6df2c5c4d2cf90cc3994ca8cb7e03fb3f265dcc72d2
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-only
PKG_LICENSE_FILES:=LICENSE

PKG_INSTALL:=0

include $(INCLUDE_DIR)/package.mk

define Package/pakon
  SECTION:=collect
  CATEGORY:=Collect
  TITLE:=PArental KONtrol - light
  DEPENDS:=+suricata-pakon +xz +python3-light +python3-logging +python3-ctypes +python3-cachetools +python3-sqlite3 +sqlite3-cli +pakon-lists +ouidb +suricata-conntrack-flows
endef

define Package/pakon/description
  Simple daemon that is able to collect events from suricata, store them locally to SQLite DB.
endef

define Build/Compile
  true
endef

define Build/Install
  true
endef

define Package/pakon/conffiles
/etc/config/pakon
endef

define Package/pakon/install
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
	/usr/libexec/pakon-light/create_db.py
	# one time fix - convert all names to lowercase. Mixed case names shouldn't be saved anymore (fixed in monitor)
	[ -f /var/lib/pakon.db ] && sqlite3 /var/lib/pakon.db "UPDATE traffic SET app_hostname = LOWER(app_hostname);" || true
	[ -f /srv/pakon/pakon-archive.db ] && /usr/bin/sqlite3 /srv/pakon/pakon-archive.db "UPDATE traffic SET app_hostname = LOWER(app_hostname);" || true
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

$(eval $(call BuildPackage,pakon))
