#
# Copyright (C) 2017 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=torsocks
PKG_VERSION:=v2.2.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git

PKG_SOURCE_URL:=https://github.com/dgoulet/torsocks.git
PKG_SOURCE_VERSION:=$(PKG_VERSION)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_MAINTAINER:=Jan Pavlinec <jan.pavlinec@nic.cz>
PKG_LICENSE:=GPL-3.0

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=IP Addresses and Names
	TITLE:=torsocks
	URL:=https://github.com/dgoulet/torsocks
	DEPENDS:=+tor
endef

define Package/$(PKG_NAME)/description
 Torsocks allows you to use most applications in a safe way with Tor.
 It ensures that DNS requests are handled safely and explicitly rejects any traffic other than TCP from the application you're using.
endef

define Build/Configure
	(cd $(PKG_BUILD_DIR); ./autogen.sh )
	$(call Build/Configure/Default)
ifeq ($(CONFIG_USE_UCLIBC),y)
	find $(PKG_BUILD_DIR) -name 'Makefile' -exec sed -i 's|--param ssp-buffer-size=1 -fstack-protector-all||' \{\} \+
endif
endef

define Build/Compile
	$(call Build/Compile/Default)
endef

define Build/Install
	$(call Build/Install/Default, install)
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/tor/
	$(CP) $(PKG_INSTALL_DIR)/etc/tor/torsocks.conf $(1)/etc/tor/
	$(INSTALL_DIR) $(1)/usr/lib/torsocks
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/torsocks/libtorsocks* $(1)/usr/lib/torsocks/
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/torsocks $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/usr/man/man5
	$(CP) $(PKG_INSTALL_DIR)/usr/man/man5/* $(1)/usr/man/man5/
	$(INSTALL_DIR) $(1)/usr/man/man8
	$(CP) $(PKG_INSTALL_DIR)/usr/man/man8/* $(1)/usr/man/man8
	$(INSTALL_DIR) $(1)/usr/man/man1
	$(CP) $(PKG_INSTALL_DIR)/usr/man/man1/* $(1)/usr/man/man1
	$(INSTALL_DIR) $(1)/usr/share/doc/torsocks
	$(CP) $(PKG_INSTALL_DIR)/usr/share/doc/torsocks/* $(1)/usr/share/doc/torsocks
endef


$(eval $(call BuildPackage,torsocks))

