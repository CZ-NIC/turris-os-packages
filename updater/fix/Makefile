#
## Copyright (C) 2019-2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=fix
# Warning: Do not bump this package!
# These packages are controlled by updater list and in general are installed and
# immediately removed. If they are kept in system they are commonly expected to
# be run only once. Because of that bump is prohibited!
PKG_VERSION:=1
PKG_RELEASE:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

Build/Compile:=:

define FIX

define Package/fix-$(1)
  SECTION:=updater
  CATEGORY:=Turris Updater
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
	$(call Package/fix-updater-v65.0-alternatives-update/DefaultInstall, $(1))
	$(INSTALL_DIR) $(1)/etc/updater/hook_postupdate
	$(INSTALL_BIN) "./files/updater-v65.0-alternatives-update" \
		$(1)/etc/updater/hook_postupdate/20_update_alternatives.sh
endef

define Package/fix-dns-forward-quad9-split/description
  DNS forwarding setting for Quad9 DNS server was splitted to filtered and unfiltered
  variant. This replaces quad9 with quad9_unfiltered setting as compatible change.
endef

define Package/fix-pkglists-options/description
  Migrate pkglists from /etc/config/updater to separate pkglists configuration
  file and set all appropriate options for pkglists.
  This is installed if pkglists version is below than 1.3.
endef

define Package/fix-uboot-env-reset/description
  This fix simply removes the file /etc/config/ubootenv. After this the
  uboot-tools package should be reinstalled to recreate that file. This is
  intended as fix to apply changes for u-boot environment configuration without
  need to hack script that creates it as that script just simply checks for
  existence of /etc/config/ubootenv file and skips execution if not located.
endef

define Package/fix-config-foris-restore/description
  With Turris OS 5.1.0 we moved config /etc/config/foris from package foris to
  package foris-controller. Unfortunately updater was not prepared for it. It
  also slipped trough testing so it landed to all users. The intention for this
  fix package is to restore latest non-empty version from snapshots.
endef

define Package/fix-all-lan-ports-in-lan/description
  There is a typo in first generation of Turris Shield that renders one LAN
  port unusable. We noticed this really late, but as Shield doesn't support
  manual interface assignements, it is safe to assume that all ports on
  switch should be part of LAN network.
endef

define Package/fix-corrupted-contract-by-rescue/description
  There was a bug in rescue images (version <3.4) that could break the environment
  configuration. This script fixes the broken environment.
endef

$(eval $(call FIX,sentinel-remove-invalid-firewall-rules,+firewall +uci))
$(eval $(call FIX,samba-migrate-to-samba4,+samba4-server +uci))
$(eval $(call FIX,updater-v65.0-alternatives-update,+updater-ng +uci,prerm))
$(eval $(call FIX,dns-forward-quad9-split,+resolver-conf +uci))
$(eval $(call FIX,pkglists-options,+pkglists))
$(eval $(call FIX,uboot-env-reset))
$(eval $(call FIX,config-foris-restore,+foris-controller +schnapps))
$(eval $(call FIX,all-lan-ports-in-lan,+uci +netifd))
$(eval $(call FIX,corrupted-contract-by-rescue,+uboot-envtools))
