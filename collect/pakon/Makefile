#
# Copyright (C) 2017-2020 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pakon
PKG_VERSION:=1.3.1
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/pakon.git
PKG_MIRROR_HASH:=04ab824e22a60378eb94018f3024e44c43397eceed99c4562f78b7d9b7f0fcc5
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-only
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/pakon
  SECTION:=collect
  CATEGORY:=Collect
  TITLE:=PArental KONtrol - light
  DEPENDS:=\
    +suricata-pakon \
    +suricata-conntrack-flows \
    +pakon-lists \
    +python3-light \
    +python3-logging \
    +python3-ctypes \
    +python3-cachetools \
    +python3-sqlite3 \
    +sqlite3-cli \
    +xz \
    +ouidb \
    +turris-auth \
    +lighttpd-mod-proxy
endef

define Package/pakon/description
  Simple daemon that is able to collect events from suricata and store them locally to SQLite DB.
endef

Build/Compile:=:

define Package/pakon/conffiles
/etc/config/pakon
endef

define Package/pakon/install
	# WebApps
	$(INSTALL_DIR) $(1)/usr/share/turris-webapps/
	$(INSTALL_DATA) ./files/webapps-pakon.json $(1)/usr/share/turris-webapps/10_pakon.json
	$(INSTALL_DIR) $(1)/www/webapps-icons/
	$(INSTALL_DATA) ./files/pakon.png $(1)/www/webapps-icons/

	# Web
	$(INSTALL_DIR) $(1)/www/pakon
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/web/index.html $(1)/www/pakon
	$(CP) -r $(PKG_BUILD_DIR)/web/static $(1)/www/pakon
	$(INSTALL_DIR) $(1)/www/cgi-bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/web/api.cgi $(1)/www/cgi-bin/pakon
	$(INSTALL_DIR) $(1)/etc/lighttpd/conf.d/
	$(INSTALL_DATA) ./files/lighttpd-pakon.conf $(1)/etc/lighttpd/conf.d/pakon.conf

	# PaKon itself
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
if [ -z "$$IPKG_INSTROOT" ]; then
	/usr/libexec/pakon-light/create_db.py
	# one time fix - convert all names to lowercase. Mixed case names shouldn't be saved anymore (fixed in monitor)
	[ -f /var/lib/pakon.db ] && sqlite3 /var/lib/pakon.db "UPDATE traffic SET app_hostname = LOWER(app_hostname);" || true
	[ -f /srv/pakon/pakon-archive.db ] && sqlite3 /srv/pakon/pakon-archive.db "UPDATE traffic SET app_hostname = LOWER(app_hostname);" || true
	/etc/init.d/pakon-monitor enable
	/etc/init.d/pakon-monitor restart 2>/dev/null
	/etc/init.d/pakon-handler enable
	/etc/init.d/pakon-handler restart 2>/dev/null
	/etc/init.d/suricata-pakon restart 2>/dev/null
	/etc/init.d/lighttpd restart 2>/dev/null
fi
endef

define Package/pakon/postrm
#!/bin/sh
if [ -z "$$IPKG_INSTROOT" ]; then
	/etc/init.d/lighttpd restart 2>/dev/null
fi
endef

define Package/pakon/prerm
#!/bin/sh
/etc/init.d/pakon-monitor disable
/etc/init.d/pakon-monitor stop
/etc/init.d/pakon-handler disable
/etc/init.d/pakon-handler stop
endef

$(eval $(call BuildPackage,pakon))
