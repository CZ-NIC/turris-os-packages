#
# Copyright (C) 2017 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pakon-light
PKG_VERSION:=0.9
PKG_RELEASE:=13
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/pakon-light.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=8d307a71829875dd61f725feefcc1172422e0236
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
	DEPENDS:=+suricata +python3-light +python3-sqlite3 +sqlite3-cli
endef

define Package/$(PKG_NAME)/description
  Simple daemon that is able to collect events from suricata, store them locally to SQLite DB.
endef

define Package/$(PKG_NAME)/conffiles
/usr/share/pakon-light/domains_replace/dist.conf
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
	$(INSTALL_DIR) $(1)/usr/share/pakon-light/domains_replace
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/domains_replace.conf $(1)/usr/share/pakon-light/domains_replace/dist.conf
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/monitor.py $(1)/usr/bin/pakon-monitor
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/show.py $(1)/usr/bin/pakon-show
	$(INSTALL_DIR) $(1)/usr/libexec/pakon-light
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/archive.py $(1)/usr/libexec/pakon-light/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/create_db.py $(1)/usr/libexec/pakon-light/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/domains_reapply.py $(1)/usr/libexec/pakon-light/
	$(INSTALL_BIN) ./files/backup_sqlite.sh $(1)/usr/libexec/pakon-light/
endef

define Package/pakon-light/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
        /etc/init.d/pakon enable
        /etc/init.d/pakon start
}
endef

define Package/pakon-light/prerm
#!/bin/sh
        /etc/init.d/pakon disable
        /etc/init.d/pakon stop
endef


$(eval $(call BuildPackage,pakon-light))
