#
## Copyright (C) 2021 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=rainbow
PKG_VERSION:=1.0.0

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/Common
  TITLE:=rainbow
  URL:=https://gitlab.nic.cz/turris/rainbow_omnia
  DEPENDS:=@(TARGET_mvebu_cortexa9_DEVICE_cznic_turris-omnia||TARGET_mpc85xx_p2020_DEVICE_turris1x||TARGET_mvebu_cortexa53_DEVICE_cznic-mox) \
endef

define Package/rainbow
  $(call Package/Common)
  DEPENDS+= +rainbow-backend
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
  Leds control on Turris Omnia, Mox and 1.x routers.
endef

define Package/rainbow-button-sync/description
  Button synchronization extension for Turris Rainbow. This is used to synchronize system configuration with hardware button.
endef

define Package/rainbow-animator/description
  Animation extension for Turris Rainbow. This is used to animate leds in case of missing or unusable kernel support.
endef

define Package/rainbow/install
	$(INSTALL_DIR) $(1)/usr/bin
	ln -sf /usr/libexec/rainbow/rainbow.sh $(1)/usr/bin/rainbow
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/rainbow.init $(1)/etc/init.d/rainbow
	$(INSTALL_DIR) $(1)/etc/config/
	touch $(1)/etc/config/rainbow

	$(INSTALL_DIR) $(1)/usr/libexec/rainbow
	$(INSTALL_BIN) ./files/rainbow.sh $(1)/usr/libexec/rainbow/
	$(INSTALL_DATA) \
		./files/animation.sh \
		./files/brightness.sh \
		./files/color.sh \
		./files/compat.sh \
		./files/led.sh \
		./files/led_activity.sh \
		./files/led_animate.sh \
		./files/ledid.sh \
		./files/pci.sh \
		./files/reset.sh \
		./files/state.sh \
		./files/uci.sh \
		./files/utils.sh \
		$(1)/usr/libexec/rainbow/
endef

define Package/rainbow-button-sync/install
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/rainbow-button-sync.init $(1)/etc/init.d/rainbow-button-sync

	$(INSTALL_DIR) $(1)/usr/libexec/rainbow
	$(INSTALL_BIN) ./files/button_sync.sh $(1)/usr/libexec/rainbow/
endef

define Package/rainbow-animator/install
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/rainbow-animator.init $(1)/etc/init.d/rainbow-animator

	$(INSTALL_DIR) $(1)/usr/libexec/rainbow
	$(INSTALL_BIN) ./files/animator.py $(1)/usr/libexec/rainbow/
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
