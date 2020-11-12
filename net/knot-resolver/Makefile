#
# Copyright (C) 2015-2020 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

PKG_RELRO_FULL:=0

include $(TOPDIR)/rules.mk

PKG_NAME:=knot-resolver
PKG_VERSION:=5.2.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://secure.nic.cz/files/knot-resolver
PKG_HASH:=8824267ca3331fa06d418c1351b68c648da0af121bcbc84c6e08f5b1e28d9433

PKG_MAINTAINER:=Knot DNS <knot-dns@labs.nic.cz>
PKG_LICENSE:=GPL-3.0-later
PKG_LICENSE_FILES:=COPYING

PKG_BUILD_DEPENDS:=meson/host

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/devel/meson/meson.mk

define Package/knot-resolver
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  TITLE:=Knot DNS Resolver
  URL:=https://www.knot-resolver.cz
  DEPENDS=+knot-libs +knot-libzscanner +libuv +luajit +dnssec-rootkey +resolver-conf +luasec +luasocket +libstdcpp +lmdb +libnghttp2
  PROVIDES:=dns-resolver
  USERID:=kresd=3536:kresd=3536
endef

define Package/knot-resolver/description
  The Knot Resolver is a caching full resolver
  implementation, including both a resolver library and a daemon.
endef

MESON_ARGS+= \
  -Ddnstap=disabled \
  -Dcapng=disabled \
  --prefix=/usr

define Package/knot-resolver/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/kresd $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/*so* $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/* $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/kresd.init $(1)/etc/init.d/kresd

	$(INSTALL_DIR) $(1)/etc/kresd
	$(CP) $(PKG_INSTALL_DIR)/etc/kresd/root.hints $(1)/etc/kresd

	$(INSTALL_BIN) ./files/kresd.postinst $(1)/etc/kresd/kresd.postinst.sh
	$(INSTALL_BIN) ./files/convert_config.sh $(1)/etc/kresd/convert_config.sh
endef

define Package/knot-resolver/postinst
#!/bin/sh
set -x
if [ -z "$$IPKG_INSTROOT" ]; then
/etc/init.d/dnsmasq restart
sleep 2 # Cooldown for above (problems in times of reinstall)
/etc/kresd/kresd.postinst.sh && rm /etc/kresd/kresd.postinst.sh
/etc/kresd/convert_config.sh && rm /etc/kresd/convert_config.sh
if [ "`uci -q get resolver.common.prefered_resolver`" = kresd ] && uci -q get resolver.common.forward_upstream | egrep -q '(1|yes|true|enabled|on)'; then
	ping -c 1 api.turris.cz 2> /dev/null >&2 || {
		uci set resolver.common.forward_upstream=0
		uci commit
		/etc/init.d/resolver restart
		if ping -c 1 api.turris.cz 2> /dev/null >&2; then
			create_notification -s error "DNS servery vašeho poskytovatele internetu nefungují úplně dobře - pravděpodobně nepodporují DNSSEC. Bylo proto vypnuto forwardování a váš router bude nyní vyhodnocovat DNS dotazy sám." "Your ISPs DNS servers does not work properly - most likely they don't support DNSSEC. Therefore DNS forwarding was turned off and your router will now resolve all DNS queries by itself."
		else
			uci set resolver.common.forward_upstream=1
			uci commit
			/etc/init.d/resolver restart
		fi
	}
fi
fi
endef

define Package/knot-resolver/prerm
#!/bin/sh
set -ex
if [ -z "$$IPKG_INSTROOT" ]; then
# Remove the script if it is there.
if [ -e /etc/init.d/kresd ] ; then /etc/init.d/kresd stop ; /etc/init.d/kresd disable ;  fi
fi
endef

define Package/knot-resolver/postrm
#!/bin/sh
if [ -z "$$IPKG_INSTROOT" ]; then
[ \! -x /etc/init.d/resolver ] || /etc/init.d/resolver restart
fi
endef

$(eval $(call BuildPackage,knot-resolver))
