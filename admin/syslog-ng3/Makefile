#
# Copyright (C) 2006-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=syslog-ng
PKG_VERSION:=3.9.1
PKG_RELEASE:=2

PKG_SOURCE_URL:=https://github.com/balabit/syslog-ng/releases/download/syslog-ng-$(PKG_VERSION)/
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_MD5SUM:=1b48da9ef620cf06e55e481b5abb677a

PKG_CONFIG_DEPENDS:= \
	CONFIG_IPV6 \

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/syslog-ng3
  SECTION:=admin
  CATEGORY:=Administration
  DEPENDS:=+libpcre +glib2 +libeventlog +libopenssl +libwrap +libpthread +librt +zlib +libdbi +psmisc +libwrap +libjson-c +libcurl +libuuid
  PROVIDES:=syslog
  TITLE:=A powerful syslog daemon
  URL:=http://www.balabit.com/network-security/syslog-ng/opensource-logging-system/
endef

define Package/syslog-ng3/description
  syslog-ng reads and logs messages to the system console, log
  files, other machines and/or users as specified by its
  configuration file.
endef

define Package/syslog-ng3/conffiles
/etc/syslog-ng.conf
endef

define Build/Configure
	$(SED) 's,-I/usr/include,,' $(PKG_BUILD_DIR)/configure
	$(Build/Configure/Default)
endef

define Package/syslog-ng3/postinst
#!/bin/sh
[ -L $${IPKG_INSTROOT}/sbin/logread ] && rm $${IPKG_INSTROOT}/sbin/logread
[ -L $${IPKG_INSTROOT}/sbin/klogd ] && rm $${IPKG_INSTROOT}/sbin/klogd
[ -L $${IPKG_INSTROOT}/sbin/syslogd ] && rm $${IPKG_INSTROOT}/sbin/syslogd

return 0
endef

CONFIGURE_ARGS +=  \
	$(call autoconf_bool,CONFIG_IPV6,ipv6) \
	--disable-dependency-tracking \
	--enable-tcp-wrapper \
	--disable-glibtest \
	--disable-spoof-source \
	--disable-sql \
	--disable-java \
	--disable-java-modules \
	--disable-redis \
	--disable-sql \
	--disable-python \
	--disable-smtp \
	--enable-prce \
	--disable-linux-caps \
	--with-librabbitmq-client=no \
	--with-mongoc=no \

TARGET_CFLAGS += -std=gnu99

TARGET_CPPFLAGS += \
	-I$(STAGING_DIR)/usr/include/eventlog

CONFIGURE_VARS += \
	LIBDBI_CFLAGS="-I$(STAGING_DIR)/usr/include"

define Package/syslog-ng3/install
	cd $(PKG_BUILD_DIR); make DESTDIR=$(1) install
	rm -rf $(1)/usr/lib/pkgconfig $(1)/usr/lib/*.a $(1)/usr/lib/*.la $(1)/usr/lib/syslog-ng/*.la
	rm -rf $(1)/etc $(1)/usr/include
	rmdir $(1)/var
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/syslog-ng.init $(1)/etc/init.d/syslog-ng
	$(INSTALL_DIR) $(1)/etc
ifdef CONFIG_USE_MUSL
	$(INSTALL_DATA) ./files/syslog-ng.conf.musl $(1)/etc/syslog-ng.conf
else
	$(INSTALL_DATA) ./files/syslog-ng.conf $(1)/etc
endif
	$(INSTALL_DIR) $(1)/etc/syslog-ng.d
	touch $(1)/etc/syslog-ng.d/.keep
endef

define Package/syslog-ng3/postinst
#!/bin/sh

[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/syslog-ng enable
/etc/init.d/syslog-ng restart
}
endef

define Package/syslog-ng3/prerm
#!/bin/sh
/etc/init.d/syslog-ng disable
/etc/init.d/syslog-ng stop
endef

$(eval $(call BuildPackage,syslog-ng3))
