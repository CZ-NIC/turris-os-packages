#
## Copyright (C) 2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=firewall-redirect-192_168_1_1
PKG_VERSION:=0.1.1
PKG_RELEASE:=$(AUTORELEASE)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/firewall-redirect-192-168-1-1
  SECTION:=net
  CATEGORY:=Base system
  TITLE:=Firewall redirect 192.168.1.1 onto router
  DEPENDS:=+firewall
endef

define Package/firewall-redirect-192-168-1-1/description
  Additional firewall rule that redirects all traffic from zone 'lan' targeting IP
  address 192.168.1.1 to local address.
endef

Build/Compile:=:

define Package/firewall-redirect-192-168-1-1/install
	$(INSTALL_DIR) $(1)/usr/libexec/
	$(INSTALL_BIN) ./files/firewall-redirect.sh $(1)/usr/libexec/firewall-redirect-192-168-1-1.sh
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/uci-defaults $(1)/etc/uci-defaults/95-firewall-redirect-192-168-1-1
endef

define Package/firewall-redirect-192-168-1-1/prerm
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	uci -q batch <<-EOF
		delete firewall.redirect_192_168_1_1
		commit firewall.redirect_192_168_1_1
	EOF
}
endef

$(eval $(call BuildPackage,firewall-redirect-192-168-1-1))
