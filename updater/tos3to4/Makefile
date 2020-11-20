#
## Copyright (C) 2019-2020 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=tos3to4
PKG_VERSION:=2.2.0
PKG_RELEASE:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/Common
  SECTION:=updater
  CATEGORY:=Turris Updater
  TITLE:=Turris OS 3.x to 4.x migration package
  DEPENDS:=+uci
endef

define Package/tos3to4
  $(call Package/Common)
  DEPENDS+=+TARGET_mvebu_cortexa9_DEVICE_cznic_turris-omnia:omnia-support
endef

define Package/tos3to4-early
  $(call Package/Common)
  TITLE+= installed early
  DEPENDS+=+switch-branch
endef

define Package/tos3to4/install
	$(INSTALL_DIR) $(1)/usr/lib/tos3to4
	$(INSTALL_BIN) ./files/sshd_config $(1)/usr/lib/tos3to4/sshd_config
	$(INSTALL_BIN) ./files/switch_and_vlans $(1)/usr/lib/tos3to4/switch_and_vlans
	$(INSTALL_BIN) ./files/wifi $(1)/usr/lib/tos3to4/wifi
	$(INSTALL_BIN) ./files/lxc $(1)/usr/lib/tos3to4/lxc
	$(INSTALL_BIN) ./files/datacollection $(1)/usr/lib/tos3to4/datacollection
ifdef CONFIG_TARGET_mvebu_cortexa9_DEVICE_cznic_turris-omnia
	$(INSTALL_BIN) ./files/sfp-omnia $(1)/usr/lib/tos3to4/sfp-omnia
endif
endef

define Package/tos3to4-early/install
	$(INSTALL_DIR) $(1)/usr/lib/tos3to4
	$(INSTALL_BIN) ./files/configure_updater $(1)/usr/lib/tos3to4/configure_updater
	$(INSTALL_BIN) ./files/localrepo $(1)/usr/lib/tos3to4/localrepo
endef

define Package/tos3to4/postinst
[ -n "$$IPKG_INSTROOT" ] || {
	ec=0
	/usr/lib/tos3to4/sshd_config || ec=$$?
	/usr/lib/tos3to4/switch_and_vlans || ec=$$?
	$(if $(CONFIG_TARGET_mvebu_cortexa9_DEVICE_cznic_turris-omnia),/usr/lib/tos3to4/sfp-omnia || ec=$$?)
	/usr/lib/tos3to4/wifi || ec=$$?
	/usr/lib/tos3to4/lxc || ec=$$?
	/usr/lib/tos3to4/datacollection || ec=$$?
	exit $$ec
}
endef

define Package/tos3to4/postrm
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || create_notification -s update \
		"Migraton from Turris OS 3.x was completed.

These are primary changes:
* Turris OS now closely tracks upstream OpenWrt development
* API tokens are no longer available and mobile application no longer works.
* Server side backups were dropped. Replacement is not yet provided.
* uCollect was removed and replaced with Sentinel.
* Automation package list with Domoticz and Home-Assistant is no longer provided.
* Majordomo is no longer available as well as its package list. Use LuCI
  statistics or Pakon instead.
* Netutils package list was dropped and most of the advanced protocols have to be
  now installed manually.
* Print server Cups was dropped. Print server package list now provides only
  p910nd protocol.
* Sound card package list was dropped. Packages are still available and you have
  to install them manually.
* Squid proxy package list was dropped. Install luci-app-squid as a replacement.
* Webcam package list been dropped. "
endef

define Package/tos3to4-early/postinst
[ -n "$$IPKG_INSTROOT" ] || {
	ec=0
	/usr/lib/tos3to4/configure_updater || ec=$$?
	/usr/lib/tos3to4/localrepo || ec=$$?
	exit $$ec
}
endef

Build/Compile:=

$(eval $(call BuildPackage,tos3to4))
$(eval $(call BuildPackage,tos3to4-early))
