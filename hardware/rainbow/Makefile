#
## Copyright (C) 2022 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=rainbow
PKG_VERSION:=0.1.0
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/rainbow-ng.git
PKG_MIRROR_HASH:=3d4e4ebcd746329c35b7a37732e6642748f612f78ffce148a2dc575c9119b5be
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/Common
  TITLE:=rainbow
  DEPENDS:=@(TARGET_mvebu_cortexa9_DEVICE_cznic_turris-omnia||TARGET_mpc85xx_p2020_DEVICE_cznic_turris1x||TARGET_mvebu_cortexa53_DEVICE_cznic_turris-mox)
  URL:=https://gitlab.nic.cz/turris/rainbow-ng
endef

define Package/rainbow
  $(call Package/Common)
  DEPENDS+= +rainbow-backend +flock
  PROVIDES:=turris-rainbow
endef

define Package/rainbow-button-sync
  $(call Package/Common)
  TITLE+=-button-sync
endef

define Package/rainbow-animator
  $(call Package/Common)
  TITLE+=-animator
  DEPENDS+= +python3-base
endef

define Package/rainbow/description
  LEDs control on Turris Omnia, Mox and 1.x routers.
endef

define Package/rainbow-button-sync/description
  Button synchronization extension for Turris Rainbow. This is used to synchronize system configuration with hardware button.
endef

define Package/rainbow-animator/description
  Animation extension for Turris Rainbow. This is used to animate leds in case of missing or unusable kernel support.
endef

define Package/rainbow/install
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/rainbow.init $(1)/etc/init.d/rainbow
	$(INSTALL_DIR) $(1)/etc/config/
	touch $(1)/etc/config/rainbow

	cd $(PKG_BUILD_DIR); make rainbow-install DESTDIR=$(1)
endef

define Package/rainbow-button-sync/install
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/rainbow-button-sync.init $(1)/etc/init.d/rainbow-button-sync

	cd $(PKG_BUILD_DIR); make button-sync-install DESTDIR=$(1)
endef

define Package/rainbow-animator/install
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/rainbow-animator.init $(1)/etc/init.d/rainbow-animator

	cd $(PKG_BUILD_DIR); make animator-install DESTDIR=$(1)
endef

define Package/rainbow/conffiles
/etc/config/rainbow
endef

Build/Compile:=:

define Package/rainbow/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	/etc/init.d/rainbow enable
	/etc/init.d/rainbow restart
}
endef

define Package/rainbow/prerm
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	/etc/init.d/rainbow stop
	/etc/init.d/rainbow disable
	rainbow all auto white
}
endef

$(eval $(call BuildPackage,rainbow))
$(eval $(call BuildPackage,rainbow-button-sync))
$(eval $(call BuildPackage,rainbow-animator))
