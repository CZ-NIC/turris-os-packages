#
# Copyright (C) 2017-2021 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=resolver-debug
PKG_VERSION:=0.0.3
PKG_RELEASE:=$(AUTORELEASE)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0

include $(INCLUDE_DIR)/package.mk

define Package/resolver-debug
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  TITLE:=Resolver debug utils
  DEPENDS:=+luci-app-commands +logrotate +syslog-ng
endef

define Package/resolver-debug/description
  Debug utils for knot-resolver and unbound.
  It adds custom commands for debugging to LuCI
  and redirects resolver log from /var/log/messages
  to /var/log/resolver
endef

Build/Compile:=:
Build/Install:=:

define Package/resolver-debug/install
	$(INSTALL_DIR) $(1)/etc/resolver
	$(INSTALL_BIN) ./files/resolver-debug.sh $(1)/etc/resolver/resolver-debug.sh

	$(INSTALL_DIR) $(1)/usr/share/syslog-ng/include/scl/resolver
	$(CP) ./files/syslog/resolver.conf $(1)/usr/share/syslog-ng/include/scl/resolver/

	$(INSTALL_DIR) $(1)/etc/logrotate.d
	$(CP) ./files/logrotate/resolver.conf $(1)/etc/logrotate.d/
endef

define Package/resolver-debug/postinst
#!/bin/sh
if [ -z "$$IPKG_INSTROOT" ]; then
	/etc/resolver/resolver-debug.sh remove-btn
	/etc/resolver/resolver-debug.sh add-btn
	/etc/init.d/syslog-ng reload
fi
endef

define Package/resolver-debug/prerm
#!/bin/sh
if [ -z "$$IPKG_INSTROOT" ]; then
	/etc/resolver/resolver-debug.sh remove-btn
fi
endef

define Package/resolver-debug/postrm
#!/bin/sh
if [ -z "$$IPKG_INSTROOT" ]; then
	/etc/init.d/syslog-ng reload
fi
endef

$(eval $(call BuildPackage,resolver-debug))
