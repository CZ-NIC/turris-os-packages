#
## Copyright (C) 2013-2020 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=lighttpd-https-cert
PKG_VERSION:=5
PKG_RELEASE:=3
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0

include $(INCLUDE_DIR)/package.mk

define Package/lighttpd-https-cert
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Web Servers/Proxies
  TITLE:=Lighttpd HTTPS support
  DEPENDS:=+lighttpd-mod-openssl
endef

define Package/lighttpd-https-cert/install
	$(INSTALL_DIR) $(1)/etc/lighttpd/conf.d/ $(1)/etc/uci-defaults
	$(INSTALL_CONF) ./files/ssl-enable.conf $(1)/etc/lighttpd/conf.d/ssl-enable.conf
	$(INSTALL_BIN) ./files/uci-defaults $(1)/etc/uci-defaults/99_lighttpd_htts_cert
endef

define Package/lighttpd-https-cert/postrm
#!/bin/sh
/etc/init.d/lighttpd restart
endef

Build/Compile:=:

$(eval $(call BuildPackage,lighttpd-https-cert))
