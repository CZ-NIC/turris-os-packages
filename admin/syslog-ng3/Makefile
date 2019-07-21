#
# Copyright (C) 2006-2019 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=syslog-ng
PKG_VERSION:=3.22.1
PKG_RELEASE:=1

PKG_LICENSE:=LGPL-2.1+
PKG_LICENSE_FILES:=COPYING
PKG_CPE_ID:=cpe:/a:balabit:syslog-ng

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/balabit/syslog-ng/releases/download/$(PKG_NAME)-$(PKG_VERSION)/
PKG_MD5SUM:=0656443776fa554320cb81bbebeac72bdf871298dd2ebef7413c393aec4d74c8

PKG_BUILD_PARALLEL:=1

PKG_CONFIG_DEPENDS:= \
	CONFIG_IPV6 \

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/syslog-ng3
  SECTION:=admin
  CATEGORY:=Administration
  DEPENDS:=+libpcre +glib2 +libopenssl +libwrap +libpthread +librt +zlib +libdbi +psmisc +libjson-c +libcurl +libuuid
  PROVIDES:=syslog
  TITLE:=A powerful syslog daemon
  URL:=https://www.syslog-ng.com/products/open-source-log-management/
endef

define Package/syslog-ng3/description
  syslog-ng reads and logs messages to the system console, log
  files, other machines and/or users as specified by its
  configuration file.
endef

define Package/syslog-ng3/conffiles
/etc/syslog-ng.conf
/etc/syslog-ng.d/
/etc/scl.conf
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
	--disable-snmp-dest \
	$(call autoconf_bool,CONFIG_IPV6,ipv6) \
	--disable-spoof-source \
	--disable-sql \
	--disable-linux-caps \
	--with-jsonc=system \
	--enable-json=yes \
	--enable-http=yes \
	--disable-smtp \
	--disable-redis \
	--disable-maxmind \
	--disable-dependency-tracking \
	--disable-python \
	--disable-geoip2 \
	--disable-java \
	--disable-java-modules \
	--with-librabbitmq-client=no \
	--with-mongoc=no

TARGET_CFLAGS += -std=gnu99

CONFIGURE_VARS += \
	LIBDBI_CFLAGS="-I$(STAGING_DIR)/usr/include"

define Package/syslog-ng3/install
	cd $(PKG_BUILD_DIR); make DESTDIR=$(1) install
	$(call libtool_remove_files,$(1)) # This removes .la files in folder (including subdirectors) /usr/lib
	rm -rf $(1)/usr/lib/pkgconfig \
	$(1)/usr/lib/*.a \
	$(1)/usr/include \
	$(1)/var

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/syslog-ng.init $(1)/etc/init.d/syslog-ng
	$(INSTALL_DIR) $(1)/etc/syslog-ng.d
	touch $(1)/etc/syslog-ng.d/.keep
ifdef CONFIG_USE_MUSL
	$(INSTALL_DATA) ./files/syslog-ng.conf.musl $(1)/etc/syslog-ng.conf
else
	$(INSTALL_DATA) ./files/syslog-ng.conf $(1)/etc
endif
	$(INSTALL_BIN) ./files/logread $(1)/usr/sbin
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
