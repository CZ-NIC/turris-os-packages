#
## Copyright (C) 2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=start-indicator
PKG_VERSION:=1
PKG_MAINTAINER:=Stepan Henek<stepan.henek@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/start-indicator.init $(1)/etc/init.d/start-indicator
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/start-indicator enable
}
endef

define Package/$(PKG_NAME)/prerm
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/start-indicator disable
}
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
