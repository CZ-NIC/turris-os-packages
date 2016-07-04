#
# Copyright (C) 2015 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

PKG_RELRO_FULL:=0

include $(TOPDIR)/rules.mk

PKG_NAME:=knot-resolver
PKG_VERSION:=1.0.0
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/knot/resolver.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_MAINTAINER:=Jan Cermak <jan.cermak@nic.cz>
PKG_LICENSE:=GPL-3.0

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/knot-resolver
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=IP Addresses and Names
	TITLE:=Knot DNS Resolver
	URL:=https://gitlab.labs.nic.cz/knot/resolver
	DEPENDS=+knot-libknot +libuv +luajit +knot-libzscanner +knot-libdnssec +dnssec-rootkey +resolver-conf
endef

define Package/knot-resolver/description
  The Knot DNS Resolver is a minimalistic caching resolver implementation.
endef

MAKE_FLAGS += \
	PREFIX=/usr

define Package/knot-resolver/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/kresd $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libkres.so* $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/kdns_modules $(1)/usr/lib

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/kresd.init $(1)/etc/init.d/kresd
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
set -ex
if [ -z "$$IPKG_INSTROOT" ]; then 
/etc/init.d/kresd enable || true
sleep 2
/etc/init.d/dnsmasq restart
sleep 2 # Cooldown for above (problems in times of reinstall)
/etc/init.d/kresd restart 
fi
endef

define Package/$(PKG_NAME)/prerm
#!/bin/sh
set -ex
if [ -z "$$IPKG_INSTROOT" ]; then

# Remove the script if it is there.
if [ -e /etc/init.d/kresd ] ; then /etc/init.d/kresd disable ; fi
fi
endef

$(eval $(call BuildPackage,knot-resolver))

