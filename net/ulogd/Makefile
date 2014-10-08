#
# Copyright (C) 2006-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ulogd
PKG_VERSION:=2.0.4
PKG_RELEASE:=7

PKG_SOURCE:=ulogd-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=\
	ftp://ftp.netfilter.org/pub/ulogd/ \
	ftp://ftp.be.netfilter.org/pub/netfilter/ulogd/ \
	ftp://ftp.de.netfilter.org/pub/netfilter/ulogd/ \
	ftp://ftp.no.netfilter.org/pub/netfilter/ulogd/
PKG_MD5SUM:=7c71ec460dfea5287eba27472c521ebc

define Package/ulogd/Default
  SECTION:=net
  CATEGORY:=Network
  URL:=http://www.netfilter.org/projects/ulogd/index.html
endef

define Package/ulogd
  $(call Package/ulogd/Default)
  DEPENDS:=+libnfnetlink +libmnl +libnetfilter-log +libnetfilter-acct +libnetfilter-conntrack +libpthread
  TITLE:=Netfilter userspace logging daemon
  MENU:=1
endef

define Package/ulogd/conffiles
/etc/default/ulogd
/etc/config/ulogd
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
  TITLE:=Output plugin for logging using DBI interface
endef

define Package/ulogd-mod-json
  $(call Package/ulogd/Default)
  DEPENDS:=ulogd +jansson
  TITLE:=Output plugin for logging to JSON
endef

define Package/ulogd-mod-xml
  $(call Package/ulogd/Default)
  DEPENDS:=ulogd
  TITLE:=Output plugin for logging to XML
endef

define Package/ulogd-mod-acct
  $(call Package/ulogd/Default)
  DEPENDS:=ulogd
  TITLE:=Plugins related to accounting objects
endef

define Package/ulogd-mod-filters
  $(call Package/ulogd/Default)
  DEPENDS:=ulogd
  TITLE:=Extra filter plugins
endef

define Package/ulogd-mod-extra
  $(call Package/ulogd/Default)
  DEPENDS:=ulogd
  TITLE:=Extra plugins
endef

define Package/ulogd-mod-extra/description
	This package contains LOCAL, LOGEMU, GRAPHITE, GPRINT, OPRINT, PWSNIFF, SYSLOG and UNIXSOCKET plugins.
endef

define Package/ulogd-mod-filters/description
	This package contains PRINTFLOW, MARK, IP2STR, HWHDR, PRINTPKT, IP2HBIN, IP2BIN, IFINDEX filter plugins.
endef

define Package/ulogd-mod-acct/description
	This package contains NFACCT and NACCT plugins.
endef

include $(INCLUDE_DIR)/package.mk

ifneq ($(Package/ulogd-mod-mysql),)
  ULOGD_MYSQL_OPTION:= --with-mysql="$(STAGING_DIR)/usr"
endif

ifneq ($(Package/ulogd-mod-pcap),)
  ULOGD_PCAP_HEADER:=yes
else
  ULOGD_PCAP_HEADER:=no
endif

ifneq ($(Package/ulogd-mod-pgsql),)
  ULOGD_PGSQL_OPTION:= --with-pgsql="$(STAGING_DIR)/usr"
endif

ifneq ($(Package/ulogd-mod-dbi),)
  ULOGD_DBI_OPTION:= --with-dbi="$(STAGING_DIR)/usr"
  ULOGD_DBI_OPTION+= --with-dbi-inc="$(STAGING_DIR)/usr/include/dbi"
  ULOGD_DBI_OPTION+= --with-dbi-lib="$(STAGING_DIR)/usr/lib"
endif

ifneq ($(Package/ulogd-mod-dbi),)
  ULOGD_JSON_OPTION:= --with-jansson
endif

define Build/Configure
	$(call Build/Configure/Default, \
		$(ULOGD_MYSQL_OPTION) \
		$(ULOGD_PGSQL_OPTION) \
		$(ULOGD_SQLITE_OPTION) \
		$(ULOGD_DBI_OPTION) \
		$(ULOGD_JSON_OPTION) \
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
	$(INSTALL_DIR) $(1)/etc/ulogd.d
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/ulogd.config $(1)/etc/config/ulogd
	$(INSTALL_DIR) $(1)/etc/logrotate.d
	$(INSTALL_CONF) ./files/ulogd.logrotate $(1)/etc/logrotate.d/ulogd
	$(LN) /var/etc/ulogd.conf $(1)/etc/ulogd.conf
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/ulogd $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/usr/lib/ulogd
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/ulogd/ulogd_inppkt_NFLOG.so $(1)/usr/lib/ulogd/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/ulogd/ulogd_inppkt_ULOG.so $(1)/usr/lib/ulogd/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/ulogd/ulogd_inpflow_NFCT.so $(1)/usr/lib/ulogd/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/ulogd/ulogd_raw2packet_BASE.so $(1)/usr/lib/ulogd/
	$(INSTALL_DIR) $(1)/etc/default
	$(INSTALL_DATA) ./files/ulogd.default $(1)/etc/default/ulogd
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/ulogd.init $(1)/etc/init.d/ulogd
endef

define BuildPlugin
  define Package/$(1)/install
	$(INSTALL_DIR) $$(1)/usr/lib/ulogd
	for m in $(2); do \
		$(CP) $(PKG_INSTALL_DIR)/usr/lib/ulogd/ulogd_$$$$$$$${m}.so $$(1)/usr/lib/ulogd/ ; \
	done
  endef

  $$(eval $$(call BuildPackage,$(1)))
endef

$(eval $(call BuildPackage,ulogd))
$(eval $(call BuildPlugin,ulogd-mod-mysql,output_MYSQL))
$(eval $(call BuildPlugin,ulogd-mod-pcap,output_PCAP))
$(eval $(call BuildPlugin,ulogd-mod-pgsql,output_PGSQL))
$(eval $(call BuildPlugin,ulogd-mod-sqlite,output_SQLITE3))
$(eval $(call BuildPlugin,ulogd-mod-dbi,output_DBI))
$(eval $(call BuildPlugin,ulogd-mod-json,output_JSON))
$(eval $(call BuildPlugin,ulogd-mod-xml,output_XML))
$(eval $(call BuildPlugin,ulogd-mod-acct,inpflow_NFACCT output_NACCT))
$(eval $(call BuildPlugin,ulogd-mod-extra,output_LOGEMU output_OPRINT output_GPRINT filter_PWSNIFF output_SYSLOG output_GRAPHITE inppkt_UNIXSOCK))
$(eval $(call BuildPlugin,ulogd-mod-filters,filter_PRINTFLOW filter_MARK filter_IP2STR filter_HWHDR filter_PRINTPKT filter_IP2HBIN filter_IP2BIN filter_IFINDEX))
