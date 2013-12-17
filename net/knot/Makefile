#
# Copyright (C) 2010-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=knot
#PKG_VERSION:=1.4.0-rc2
#PKG_RELEASE:=1

#PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
#PKG_SOURCE_URL:=https://secure.nic.cz/files/knot-dns/
#PKG_MD5SUM:=39f10b2332ed37ab642fc768c83fd23f


PKG_VERSION:=1
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/labs/knot.git
PKG_SOURCE_VERSION:=168b53199c11b34c1ef19fc3dccb6ccf3ea93b31
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Stepan Henek <stepan.henek@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

#PKG_BUILD_DEPENDS:=libexpat
PKG_BUILD_PARALLEL:=1
PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/knot/Default
  TITLE:=High-performance authoritative-only DNS server
  URL:=http://www.unbound.net/
  DEPENDS:=+liburcu +libopenssl
  SUBMENU:=IP Addresses and Names
endef

define Package/knot
  $(call Package/knot/Default)
  SECTION:=net
  CATEGORY:=Network
  TITLE+= (server)
endef

define Package/knot-tests
  $(call Package/knot/Default)
  SECTION:=net
  CATEGORY:=Network
  TITLE+= (tests)
  DEPENDS+= +knot
endef

define Package/knot/description
  This package contains the Knot server.
endef

define Package/knot-tests/description
  This package contains tests for the Knot server.
endef

#CONFIGURE_ARGS += \
#	--disable-ecdsa \
#	--disable-gost \
#	--enable-allsymbols \
#	--with-ldns="$(STAGING_DIR)/usr" \
#	--with-libexpat="$(STAGING_DIR)/usr" \
#	--with-ssl="$(STAGING_DIR)/usr" \
#	--without-pthreads

define Package/knot/conffiles
	/etc/knot/knot.conf
endef

TARGET_CFLAGS += -std=gnu99

#define Build/InstallDev
	#$(INSTALL_DIR) $(1)/usr/lib
	#$(CP) $(PKG_INSTALL_DIR)/usr/lib/libknot.{so*,a,la} $(1)/usr/lib/
#endef

#MAKEFLAGS += 

define Build/Compile	
	$(MAKE) -C $(PKG_BUILD_DIR)
	$(MAKE) -C $(PKG_BUILD_DIR) check-compile-only
endef



define Package/knot/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/sbin/knot{c,d} \
		$(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/etc/knot
	$(INSTALL_CONF) ./files/knot.conf $(1)/etc/knot/
	$(INSTALL_CONF) ./files/example.com.zone $(1)/etc/knot/
endef

define Package/knot-tests/install
	$(INSTALL_DIR) $(1)/usr/share/knot/tests
	for f in $(PKG_BUILD_DIR)/tests/* ; do \
		[[ "$$$${f}" =~ \.o$  ]] && continue ; \
		[[ "$$$${f}" =~ \.c$  ]] && continue ; \
		[[ "$$$${f}" =~ \.h$  ]] && continue ; \
		[[ "$$$${f}" =~ README$  ]] && continue ; \
		[[ "$$$${f}" =~ TESTS$  ]] && continue ; \
		[[ "$$$${f}" =~ TODO$  ]] && continue ; \
		[[ "$$$${f}" =~ Makefile.inc$  ]] && continue ; \
		[[ "$$$${f}" =~ TAP$  ]] && continue ; \
		[[ "$$$${f}" =~ tap$  ]] && continue ; \
		[[ "$$$${f}" =~ data$  ]] && continue ; \
		$(INSTALL_BIN) "$$$${f}" $(1)/usr/share/knot/tests/ ; \
	done
	$(INSTALL_DIR) $(1)/usr/share/knot/tests/data/
	$(CP) $(PKG_BUILD_DIR)/tests/data/* $(1)/usr/share/knot/tests/data/
endef

$(eval $(call BuildPackage,knot))
$(eval $(call BuildPackage,knot-tests))
