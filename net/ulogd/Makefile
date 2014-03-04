#
# Copyright (C) 2006-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ulogd
PKG_VERSION:=2.0.3
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=ftp://ftp.netfilter.org/pub/ulogd/
PKG_MD5SUM:=4dcd7e7a68022318759b8d3b9fff7519

define Package/ulogd/Default
  SECTION:=net
  CATEGORY:=Network
  URL:=http://www.netfilter.org/projects/ulogd/index.html
endef

define Package/ulogd
  $(call Package/ulogd/Default)
  DEPENDS:=+iptables-mod-ulog +libnfnetlink +libnetfilter-conntrack +libnetfilter-log +libmnl +libpthread
  TITLE:=Netfilter userspace logging daemon
  MENU:=1
endef

define Package/ulogd/conffiles
/etc/default/ulogd
/etc/ulogd.conf
endef

define Package/ulogd-mod-mysql
  $(call Package/ulogd/Default)
  DEPENDS:=ulogd +libmysqlclient
  TITLE:=Output plugin for logging to a MySQL database
endef

define Package/ulogd-mod-pcap
  $(call Package/ulogd/Default)
  DEPENDS:=ulogd +libpcap
  TITLE:=Output plugin for logging in pcap format
endef

define Package/ulogd-mod-pgsql
  $(call Package/ulogd/Default)
  DEPENDS:=ulogd +libpq
  TITLE:=Output plugin for logging to a PostgreSQL database
endef

define Package/ulogd-mod-sqlite
  $(call Package/ulogd/Default)
  DEPENDS:=ulogd +libsqlite3
  TITLE:=Output plugin for logging to an SQLite database
endef

define Package/ulogd-mod-dbi
  $(call Package/ulogd/Default)
  DEPENDS:=ulogd +libdbi
  TITLE:=Output plugin for logging to an database independent layer
endef

define Package/ulogd-mod-extra
  $(call Package/ulogd/Default)
  DEPENDS:=ulogd
  TITLE:=Extra plugins
endef

define Package/ulogd-mod-extra/description
	This package contains the LOCAL, LOGEMU, OPRINT, PWSNIFF and SYSLOG plugins.
endef

include $(INCLUDE_DIR)/package.mk

ifneq ($(Package/ulogd-mod-mysql),)
  ULOGD_MYSQL_OPTION:= --with-mysql="$(STAGING_DIR)/usr"
else
  ULOGD_MYSQL_OPTION:= --without-mysql
endif

ifneq ($(Package/ulogd-mod-pcap),)
  ULOGD_PCAP_HEADER:=yes
else
  ULOGD_PCAP_HEADER:=no
endif

ifneq ($(Package/ulogd-mod-pgsql),)
  ULOGD_PGSQL_OPTION:= --with-pgsql="$(STAGING_DIR)/usr"
else
  ULOGD_PGSQL_OPTION:= --without-pgsql
endif

ifneq ($(Package/ulogd-mod-sqlite),)
  ULOGD_SQLITE_OPTION:= --with-sqlite="$(STAGING_DIR)/usr"
else
  ULOGD_SQLITE_OPTION:= --without-sqlite
endif

ifneq ($(Package/ulogd-mod-dbi),)
  ULOGD_DBI_OPTION:= --with-dbi="$(STAGING_DIR)/usr" \
		--with-dbi-inc="$(STAGING_DIR)/usr/include/dbi" \
		--with-dbi-lib="$(STAGING_DIR)/usr/lib"
else
  ULOGD_DBI_OPTION:= --without-dbi
endif

CONFIGURE_VARS += PKG_CONFIG=$(STAGING_DIR_HOST)/bin/pkg-config

define Build/Configure
	$(call Build/Configure/Default, \
		$(ULOGD_MYSQL_OPTION) \
		$(ULOGD_PGSQL_OPTION) \
		$(ULOGD_SQLITE_OPTION) \
                $(ULOGD_DBI_OPTION) \
		--disable-nfacct \
		, \
		ac_cv_header_pcap_h=$(ULOGD_PCAP_HEADER) \
	)
	$(SED) 's/-lgcc_s//g' $(PKG_BUILD_DIR)/Rules.make
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		CFLAGS="$(TARGET_CFLAGS) \
			-Iinclude \
			-I$(PKG_BUILD_DIR)/include/ulogd \
			-I$(PKG_BUILD_DIR)/include \
			-I$(PKG_BUILD_DIR)/libipulog/include \
			-Wl,--export-dynamic \
			$(TARGET_CPPFLAGS)" \
		all install
endef

define Package/ulogd/install
	$(INSTALL_DIR) $(1)/etc
	$(CP) $(PKG_BUILD_DIR)/ulogd.conf $(1)/etc/
	
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/ulogd $(1)/usr/sbin/
	
	$(INSTALL_DIR) $(1)/usr/lib/ulogd
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/ulogd/ulogd_raw2packet_BASE.so $(1)/usr/lib/ulogd/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/ulogd/ulogd_inppkt_NFLOG.so $(1)/usr/lib/ulogd/
	
	$(INSTALL_DIR) $(1)/etc/default
	$(INSTALL_DATA) ./files/ulogd.default $(1)/etc/default/ulogd
	
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/ulogd.init $(1)/etc/init.d/ulogd
endef

define BuildPlugin
  define Package/$(1)/install
	$(INSTALL_DIR) $$(1)/usr/lib/ulogd
	for m in $(2); do \
		$(CP) $(PKG_INSTALL_DIR)/usr/lib/ulogd/ulogd_*_$$$$$$$${m}.so $$(1)/usr/lib/ulogd/ ; \
	done
  endef

  $$(eval $$(call BuildPackage,$(1)))
endef

$(eval $(call BuildPackage,ulogd))
$(eval $(call BuildPlugin,ulogd-mod-mysql,MYSQL))
$(eval $(call BuildPlugin,ulogd-mod-pcap,PCAP))
$(eval $(call BuildPlugin,ulogd-mod-pgsql,PGSQL))
$(eval $(call BuildPlugin,ulogd-mod-sqlite,SQLITE3))
$(eval $(call BuildPlugin,ulogd-mod-dbi,DBI))
$(eval $(call BuildPlugin,ulogd-mod-extra,LOGEMU OPRINT PWSNIFF SYSLOG))
