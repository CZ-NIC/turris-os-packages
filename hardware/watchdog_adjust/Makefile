#
## Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=watchdog_adjust
PKG_VERSION:=6
PKG_RELEASE:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/watchdog_adjust
	TITLE:=Watchdog adjust
endef

Build/Compile:=:

define Package/watchdog_adjust/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/watchdog_adjust disable
/etc/init.d/watchdog_adjust enable || true
}
endef

define Package/watchdog_adjust/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/watchdog_adjust $(1)/etc/init.d/watchdog_adjust
endef

$(eval $(call BuildPackage,watchdog_adjust))
