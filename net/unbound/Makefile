#
# Copyright (C) 2010-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=unbound
PKG_VERSION:=1.7.3
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.unbound.net/downloads
PKG_MD5SUM:=c11de115d928a6b48b2165e0214402a7a7da313cd479203a7ce7a8b62cba602d

PKG_BUILD_DEPENDS:=libexpat
PKG_BUILD_PARALLEL:=1
PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/unbound/Default
  TITLE:=A validating, recursive & caching DNS resolver
  URL:=http://www.unbound.net/
  DEPENDS:=+libldns +libopenssl +dnssec-rootkey +resolver-conf
  PROVIDES:=dns-resolver
endef

ifeq ($(CONFIG_TARGET_mpc85xx_p2020_nand_TURRISNAND),y)

TURRIS_DEPS:=+cert-backup
endif

ifeq ($(CONFIG_TARGET_mvebu_Turris-Omnia),y)

TURRIS_DEPS:=+cert-backup
endif

define Package/unbound
  $(call Package/unbound/Default)
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  TITLE+= (daemon)
  DEPENDS+= +libunbound +cert-backup
endef

define Package/unbound/description
  This package contains the Unbound daemon.
endef

define Package/unbound-anchor
  $(call Package/unbound/Default)
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  TITLE+= (anchor utility)
  DEPENDS+= +unbound +libexpat
endef

define Package/unbound-anchor/description
  This package contains the Unbound anchor utility.
endef

define Package/unbound-control/description
  This package contains the Unbound control utility.
endef

define Package/unbound-control-setup
  $(call Package/unbound/Default)
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  TITLE+= (control setup utility)
  DEPENDS+= +unbound-control +openssl-util
endef

define Package/unbound-control-setup/description
  This package contains the Unbound control setup utility.
endef

define Package/unbound-host
  $(call Package/unbound/Default)
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  TITLE+= (DNS lookup utility)
  DEPENDS+= +libunbound
endef

define Package/unbound-host/description
  This package contains the Unbound DNS lookup utility.
endef

define Package/libunbound
  $(call Package/unbound/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE+= (library)
endef

define Package/libunbound/description
  This package contains the Unbound shared library.
endef

CONFIGURE_ARGS += \
	--disable-gost \
	--enable-allsymbols \
	--with-ldns="$(STAGING_DIR)/usr" \
	--with-libexpat="$(STAGING_DIR)/usr" \
	--with-ssl="$(STAGING_DIR)/usr" \
	--without-pthreads

define Package/unbound/conffiles
/etc/unbound/unbound.conf
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/unbound.h $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libunbound.{so*,a,la} $(1)/usr/lib/
endef

define Package/unbound/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/sbin/unbound \
		$(PKG_INSTALL_DIR)/usr/sbin/unbound-checkconf \
		$(1)/usr/sbin/

	$(CP) $(PKG_INSTALL_DIR)/usr/sbin/unbound-control $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/etc/unbound
	$(INSTALL_CONF) ./files/named.cache $(1)/etc/unbound/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/unbound-init $(1)/etc/init.d/unbound
	$(INSTALL_DIR) $(1)/usr/share/unbound/
	$(INSTALL_BIN) ./files/unbound.postinst $(1)/usr/share/unbound/postinst
	$(LN) /var/etc/unbound/unbound.conf $(1)/etc/unbound/unbound.conf
endef

define Package/unbound/postinst
#!/bin/sh
set -ex
[ -n "$$IPKG_INSTROOT" ] || {
/usr/share/unbound/postinst
}
endef

define Package/unbound/prerm
#!/bin/sh
set -ex
if [ -z "$$IPKG_INSTROOT" ]; then
/etc/init.d/unbound disable
/etc/init.d/unbound stop
uci set resolver.common.prefered_resolver="kresd"
uci commit
fi
endef

define Package/unbound/postrm
#!/bin/sh
if [ -z "$$IPKG_INSTROOT" ]; then
[ \! -x /etc/init.d/resolver ] || /etc/init.d/resolver restart
fi
endef

define Package/unbound-anchor/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(CP) $(PKG_INSTALL_DIR)/usr/sbin/unbound-anchor $(1)/usr/sbin/
endef

define Package/unbound-control/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(CP) $(PKG_INSTALL_DIR)/usr/sbin/unbound-control $(1)/usr/sbin/
endef

define Package/unbound-control-setup/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(CP) $(PKG_INSTALL_DIR)/usr/sbin/unbound-control-setup $(1)/usr/sbin/
endef

define Package/unbound-host/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(CP) $(PKG_INSTALL_DIR)/usr/sbin/unbound-host $(1)/usr/sbin/
endef

define Package/libunbound/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libunbound.so.* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,unbound))
$(eval $(call BuildPackage,unbound-anchor))
$(eval $(call BuildPackage,unbound-control-setup))
$(eval $(call BuildPackage,unbound-host))
$(eval $(call BuildPackage,libunbound))
