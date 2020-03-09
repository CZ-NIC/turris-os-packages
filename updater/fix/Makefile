#
## Copyright (C) 2019-2020 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=fix
PKG_VERSION:=1
PKG_RELEASE:=1
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

Build/Compile:=:

define FIX

define Package/fix-$(1)
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Fixes
  TITLE:=$(1)
  DEPENDS:=$(2)
endef

define Package/fix-$(1)/DefaultInstall
	$(INSTALL_DIR) $$(1)/usr/libexec/fix
	$(INSTALL_BIN) ./files/$(1) $$(1)/usr/libexec/fix/$(1)
endef

Package/fix-$(1)/install ?= $$(Package/fix-$(1)/DefaultInstall)

define Package/fix-$(1)/$(or $(3),postinst)
#!/bin/sh
/usr/libexec/fix/$(1)
endef

$$(eval $$(call BuildPackage,fix-$(1)))

endef


define Package/fix-sentinel-remove-invalid-firewall-rules/description
  This is used to remove data collection firewall rules before we update those
  packages. Initial requirement was because originaly those rules were not fully
  inserted and so they were invalid. Although this can be reused later.
endef

define Package/fix-samba-migrate-to-samba4/description
  With Turris OS 5.0 Samba4 was introduced and switch to it was performed in
  package lists. To support parallel installation of both Samba3 and Samba4
  OpenWrt chose to have two separate configs. This fix package migrates existing
  configuration from Samba3 to Samba4 specific configuration file.
endef

define Package/fix-updater-v65.0-alternatives-update/description
  Updater version 65.0 introduced built-in support for Alternatives. Until then
  Alternatives were supported by postupdate hook script. The problem is that
  script is removed as part of update but currently running updater is not
  handling Alternatives yet so we need to fix them after such update.
  This just calls original script (now packaged as utility script) on removal. The
  reason why on removal is that this is removed once new version of package is
  installed and that ensures that now everything is going to be correctly linked.
endef

define Package/fix-updater-v65.0-alternatives-update/install
	$(call Package/fix-updater-v65.0-alternatives-update/DefaultInstall)
	$(INSTALL_DIR) $(1)/etc/updater/hook_postupdate
	$(INSTALL_BIN) "./files/updater-v65.0-alternatives-update" \
		$(1)/etc/updater/hook_postupdate/20_update_alternatives.sh
endef

$(eval $(call FIX,sentinel-remove-invalid-firewall-rules,+firewall +uci))
$(eval $(call FIX,samba-migrate-to-samba4,+samba4-server +uci))
$(eval $(call FIX,updater-v65.0-alternatives-update,+updater-ng +uci,prerm))
