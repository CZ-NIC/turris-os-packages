#
# Copyright (C) 2017-2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pakon
PKG_VERSION:=1.2.2
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/pakon-light.git
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_VERSION:=06ffc7904e7d97939198e5962e2ff573b3080c02
PKG_SOURCE_SUBDIR:=pakon-light
PKG_BUILD_DIR:=$(BUILD_DIR)/pakon-light-$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=COPYING

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

PKG_UNPACK:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

define Package/pakon
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Collect traffic events from suricata IDS
  TITLE:=PArental KONtrol - light
  DEPENDS:=+suricata-pakon +xz +python3-light +python3-logging +python3-ctypes +python3-cachetools +python3-sqlite3 +sqlite3-cli +pakon-lists +ouidb +suricata-conntrack-flows
  VARIANT:=python3
endef

define Package/pakon/description
  Simple daemon that is able to collect events from suricata, store them locally to SQLite DB.
endef

define Package/pakon/conffiles
/etc/config/pakon
/etc/config/pakon-alert
/etc/config/pakon-flow
endef

define Py3Package/pakon/install
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
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/usr/libexec/pakon-light
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/notify_new_device.sh $(1)/usr/libexec/pakon-light/
	$(INSTALL_BIN) ./files/backup_sqlite.sh $(1)/usr/libexec/pakon-light/
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/config_files/alert $(1)/etc/config/pakon-alert
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/config_files/flow $(1)/etc/config/pakon-flow
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/config_files/pakon $(1)/etc/config/pakon
endef

define Package/pakon/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	/usr/bin/pakon-maintain create-databases
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
[ -n "$$IPKG_INSTROOT" ] || {
	/etc/init.d/pakon-monitor disable
	/etc/init.d/pakon-monitor stop
	/etc/init.d/pakon-handler disable
	/etc/init.d/pakon-handler stop
}
endef

$(eval $(call Py3Package,pakon))
$(eval $(call BuildPackage,pakon))
$(eval $(call BuildPackage,pakon-src))
