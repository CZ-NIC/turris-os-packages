#
## Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=tos3to4
PKG_VERSION:=2.0.6
PKG_RELEASE:=1
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/tos3to4
  TITLE:=Turris OS 3.x to 4.x migration package
  DEPENDS:=+uci +TARGET_mvebu_cortexa9_DEVICE_turris-omnia:omnia-support
endef

define Package/tos3to4-early
  TITLE:=Turris OS 3.x to 4.x migration package installed early
  DEPENDS:=+uci +switch-branch
endef

define Package/tos3to4/install
	$(INSTALL_DIR) $(1)/usr/lib/tos3to4
	$(INSTALL_BIN) ./files/switch_and_vlans $(1)/usr/lib/tos3to4/switch_and_vlans
	$(INSTALL_BIN) ./files/wifi $(1)/usr/lib/tos3to4/wifi
ifdef CONFIG_TARGET_mvebu_cortexa9_DEVICE_turris-omnia
	$(INSTALL_BIN) ./files/sfp-omnia $(1)/usr/lib/tos3to4/sfp-omnia
endif
endef

define Package/tos3to4-early/install
	$(INSTALL_DIR) $(1)/usr/lib/tos3to4
	$(INSTALL_BIN) ./files/configure_updater $(1)/usr/lib/tos3to4/configure_updater
endef

define Package/tos3to4/postinst
[ -n "$$IPKG_INSTROOT" ] || {
	ec=0
	/usr/lib/tos3to4/switch_and_vlans || ec=$$?
	/usr/lib/tos3to4/wifi || ec=$$?
	$(if $(CONFIG_TARGET_mvebu_cortexa9_DEVICE_turris-omnia),/usr/lib/sfp-omnia || ec=$$?)
	exit $$ec
}
endef

define Package/tos3to4-early/postinst
[ -n "$$IPKG_INSTROOT" ] || /usr/lib/tos3to4/configure_updater
endef

Build/Compile:=

$(eval $(call BuildPackage,tos3to4))
$(eval $(call BuildPackage,tos3to4-early))
