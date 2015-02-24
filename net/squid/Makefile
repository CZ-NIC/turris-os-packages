#
# Copyright (C) 2006-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=squid
PKG_VERSION:=3.5.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://www.squid-cache.org/Versions/v3/3.5/
PKG_MD5SUM:=3c4d77ae25c7dee1f5ec597a069e0a53
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/squid/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Web Servers/Proxies
  URL:=http://www.squid-cache.org/
endef

define Package/squid
  $(call Package/squid/Default)
  MENU:=1
  DEPENDS:=+libopenssl +libpthread +librt +libltdl +libstdcpp
  TITLE:=full-featured Web proxy cache
endef

define Package/squid/description
	Squid is a high-performance proxy caching server for web clients,
	supporting FTP, gopher, and HTTP data objects. Unlike traditional
	caching software, Squid handles all requests in a single,
	non-blocking, I/O-driven process.
endef

define Package/squid/conffiles
/etc/squid/mime.conf
/etc/squid/squid.conf
endef

define Package/squid-mod-cachemgr
  $(call Package/squid/Default)
  DEPENDS:=squid
  TITLE:=Web based proxy manager and reporting tool
endef

CONFIGURE_ARGS += \
	--datadir=/usr/share/squid \
	--libexecdir=/usr/lib/squid \
	--sysconfdir=/etc/squid \
	--enable-shared \
	--enable-static \
	--enable-x-accelerator-vary \
	--with-pthreads \
	--with-dl \
	--enable-icmp \
	--enable-kill-parent-hack \
	--enable-arp-acl \
	--enable-ssl \
	--enable-htcp \
	--enable-err-languages=English \
	--enable-default-err-language=English \
	--enable-linux-netfilter \
	--enable-icmp \
	--disable-external-acl \
	--enable-underscores \
	--enable-cache-digests \
	--enable-referer-log \
	--enable-delay-pools \
	--enable-useragent-log \
	--disable-auth \
	--with-openssl=$(STAGING_DIR)/usr \
	--enable-storeio=ufs,aufs \
	--enable-epoll \
	--with-maxfd=4096 \
	--without-libcap \
	--without-nettle \
	--without-netfilter-conntrack \
	--with-krb5-config=no

CONFIGURE_VARS += \
	ac_cv_header_linux_netfilter_ipv4_h=yes \
	ac_cv_epoll_works=yes \

define Build/Compile
	# pass INCLUDES to compile host sources against our OpenSSL, not the host one
	$(MAKE) -C $(PKG_BUILD_DIR)/lib \
		all
	$(MAKE) -C $(PKG_BUILD_DIR) \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		install
endef

define BuildPlugin
  define Package/$(1)/install
	$(INSTALL_DIR) $$(1)/usr/lib/squid
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/squid/$(2) $$(1)/usr/lib/squid/
  endef

  $$(eval $$(call BuildPackage,$(1)))
endef

define Package/squid/install
	$(INSTALL_DIR) $(1)/etc/squid $(1)/etc/cron.d $(1)/etc/init.d
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/etc/squid/mime.conf $(1)/etc/squid/
	$(INSTALL_DATA) files/squid.conf $(1)/etc/squid/
	$(INSTALL_DATA) files/squid.cron $(1)/etc/cron.d/squid
	$(INSTALL_BIN) files/squid.init $(1)/etc/init.d/squid
	$(INSTALL_DIR) $(1)/usr/share/squid
	$(CP) $(PKG_INSTALL_DIR)/usr/share/squid/* $(1)/usr/share/squid/
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/squid $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/usr/lib/squid
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/squid/{unlinkd,pinger,log_file_daemon} $(1)/usr/lib/squid/
	chmod u+s $(1)/usr/lib/squid/pinger
endef

define Package/squid/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
if /etc/init.d/squid enabled ; then
	/etc/init.d/squid restart
fi
}
endef

define Package/squid-mod-cachemgr/install
	$(INSTALL_DIR) $(1)/www/cgi-bin/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/squid/cachemgr.cgi $(1)/www/cgi-bin/
endef

$(eval $(call RequireHeader,/usr/include/openssl/ssl.h, \
	$(PKG_NAME) requires the openssl development (named like libssl-dev, \
	depending of your package manager) package be installed on the host-system. \
))

$(eval $(call BuildPackage,squid))
$(eval $(call BuildPackage,squid-mod-cachemgr))
