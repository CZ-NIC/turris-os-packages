#
## Copyright (C) 2018-2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=start-indicator
PKG_VERSION:=0
PKG_RELEASE:=2

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-2.0-or-later

include $(INCLUDE_DIR)/package.mk

define Package/start-indicator
  TITLE:=start-indicator
  DEPENDS:=+turris-rainbow
endef

define Package/start-indicator/install
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/start-indicator.init $(1)/etc/init.d/start-indicator
endef

define Package/start-indicator/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/start-indicator enable
}
endef

define Package/start-indicator/prerm
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/start-indicator disable
}
endef

$(eval $(call BuildPackage,start-indicator))
