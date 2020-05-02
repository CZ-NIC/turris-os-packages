#
## Copyright (C) 2013-2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=turris1x-rainbow
PKG_VERSION:=17
PKG_RELEASE:=3

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/rainbow.git
PKG_SOURCE_VERSION:=5d7d5c8c3bdec184bdb418e857a6d5a11726fac4


PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/turris1x-rainbow
  TITLE:=turris1x-rainbow
  URL:=https://gitlab.labs.nic.cz/turris/rainbow
  PROVIDES:=turris-rainbow
  DEPENDS:=@KERNEL_DEVMEM @TARGET_mpc85xx_p2020_DEVICE_turris1x
endef

define Package/turris1x-rainbow/conffiles
/etc/config/rainbow
endef

define Package/turris1x-rainbow/install
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/rainbow $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/rainbow.init $(1)/etc/init.d/rainbow
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_DATA) ./files/rainbow.config $(1)/etc/config/rainbow
	$(INSTALL_DIR) $(1)/etc/cron.d
	$(INSTALL_DATA) ./files/rainbow.cron $(1)/etc/cron.d/rainbow
	$(INSTALL_BIN) ./files/rainbow_button_sync.sh $(1)/usr/bin/rainbow_button_sync.sh
endef

define Package/turris1x-rainbow/prerm
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || \
	rainbow all auto white
endef

$(eval $(call BuildPackage,turris1x-rainbow))
