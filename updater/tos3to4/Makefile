#
## Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=tos3to4
PKG_VERSION:=2.0
PKG_RELEASE:=1
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/tos3to4
  TITLE:=Turris OS 3.x to 4.x migration package
  DEPENDS:=+uci
endef

define Package/tos3to4-early
  TITLE:=Turris OS 3.x to 4.x migration package installed early
  DEPENDS:=+uci
endef

define Package/tos3to4/install
	$(INSTALL_DIR) /usr/lib/tos3to4
	$(INSTALL_BIN) ./files/switch_and_vlans /usr/lib/tos3to4/switch_and_vlans
endef

define Package/tos3to4-early/install
	$(INSTALL_DIR) /usr/lib/tos3to4
	$(INSTALL_BIN) ./files/configure_updater /usr/lib/tos3to4/configure_updater
endef

define Package/tos3to4/postinst
[ -n "$$IPKG_INSTROOT" ] || {
	ec=0
	/usr/lib/tos3to4/switch_and_vlans || ec=$$?
	exit $$ec
}
endef

define Package/tos3to4-early/postinst
[ -n "$$IPKG_INSTROOT" ] || /usr/lib/tos3to4/configure_updater
endef

Build/Compile:=

$(eval $(call BuildPackage,tos3to4))
$(eval $(call BuildPackage,tos3to4-early))
