#
# Copyright (C) 2017-2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=torsocks
PKG_VERSION:=2.3.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG__VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/dgoulet/torsocks/tar.gz/v$(PKG_VERSION)?

PKG_MAINTAINER:=Jan Pavlinec <jan.pavlinec@nic.cz>
PKG_LICENSE:=GPLv2
PKG_LICENSE_FILES:=LICENSE

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/torsocks
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=IP Addresses and Names
	TITLE:=torsocks
	URL:=https://github.com/dgoulet/torsocks
	DEPENDS:=+tor
endef

define Package/torsocks/description
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

define Package/torsocks/install
	$(INSTALL_DIR) $(1)/etc/tor/
	$(CP) $(PKG_INSTALL_DIR)/etc/tor/torsocks.conf $(1)/etc/tor/
	$(INSTALL_DIR) $(1)/usr/lib/torsocks
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/torsocks/libtorsocks* $(1)/usr/lib/torsocks/
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/torsocks $(1)/usr/bin/
endef

$(eval $(call BuildPackage,torsocks))