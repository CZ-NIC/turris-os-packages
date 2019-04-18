#
## Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=tos3to4
PKG_VERSION:=1.0.1
PKG_RELEASE:=1
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/tos3to4
  TITLE:=tos3to4
  DEPENDS:=@(TARGET_mvebu_Turris-Omnia||TARGET_mpc85xx_p2020_nand||TARGET_mpc85xx_p2020_nor)
endef

ifdef CONFIG_TARGET_mvebu_Turris-Omnia
BOARD=omnia
else
BOARD=turris1x
endif

define Package/tos3to4/install
	$(INSTALL_DIR) $(1)/etc/updater/conf.d
	$(INSTALL_BIN) ./files/migrate3to4.lua $(1)/etc/updater/conf.d/migrate3to4.lua
	$(INSTALL_BIN) ./files/os-release-$(BOARD) $(1)/etc/os-release
endef

define Package/tos3to4/postinst
[ -n "$$IPKG_INSTROOT" ] || {
	. /lib/functions.sh
	uci_load updater
	config_get autorun_approvals approvals need 0
	if [ "$$approvals" = "1" ]; then
		uci set "updater.approvals.need_migrate=1"
		uci set "updater.approvals.need=0"
		uci commit updater.approvals
		create_notification -s error 'Updater approvals were deactivated to prevent problems during migration to latest major release of Turris OS!'
	fi
}
endef

Build/Compile:=:

$(eval $(call BuildPackage,tos3to4))
