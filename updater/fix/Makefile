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
PKG_RELEASE:=$(AUTORELEASE)

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
exec /usr/libexec/fix/$(1)
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

define Package/fix-updater-rm-log/description
  Remove obsolete and growing updater's log (/usr/share/updater/updater-log).
  This log is no longer maintained by updater and it makes no sense to keep it in
  system.
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

define Package/fix-cleanup-cert-backup/description
  Remove obsolete custom certificates from cert-bakup storage.
  They originally belonged to now removed cznic-cacert-bundle package.
endef

define Package/fix-edns-buffer-size/description
  edns buffer size in DNS setting was changed from default value 4096 to 1232.
  This change is related to DNS Flag Day 2020.
endef

define Package/fix-dhparam-to-cagen/description
  This is fix for removal of dhparam package. It is replaced with turris-cagen. It
  is required to ensure that new file is in new expected location and that openvpn
  is using it.
endef

define Package/fix-pkglists-hardening-options/description
  Content of package list hardening was moved to conditional options that are not
  automatically enabled. To keen user's configuration consistent this fix package
  enables appropriate options for hardening package list if hardening is enabled.
endef

define Package/fix-nor-update/description
  Sometimes we need to trigger update of the content of NOR memory - like U-Boot
  or rescue image. This fix updates it to the latest stable version.
endef

define Package/fix-nextcloud-conf/description
  Nextcloud cron scripts accidentally creates an empty config.php file.
  If there is empty config.php, which exists then it removes it.
endef

define Package/fix-sentinel-nikola-to-fwlogs/description
  Sentinel Nikola is being replaced by Sentinel FWLogs. They are pretty much
  compatible with exception of one UCI section name. This renames this UCI config
  (sentinel.nikola -> sentinel.fwlogs). This way Nikola configuration is migrated
  to FWLogs and Nikola can be removed.
endef

define Package/fix-pkglists-nikola-to-fwlogs/description
  Sentinel Nikola is being replaced by Sentinel FWLogs. This fixes rename of
  option in datacollect package list.
endef

define Package/fix-lighttpd-sync-with-upstream/description
  We are getting close to dropping our maintained package lighttpd in favor of
  upstream variant, but before we are able to do it, we need to move
  files from /etc/lighttpd/modules.d/ to /etc/lighttpd/conf.d/
  and rename their suffix from .load to .conf. If we don't do it, then
  UI is not accessible and it wants to download file with name download,
  because lighttpd in OpenWrt does not use the first mentioned folder
  modules.d
endef

define Package/fix-firewall-zone-limit/description
  The OpenWrt 21.02 introduced the limit for 11 characters for firewall zone
  names. The reason is that they are used in iptables as chain names and 11
  characters is maximum possible legth (plus the characters the firewall3 adds
  on its own automatically).
  This fix trims all zone names to 11 characters.
endef

define Package/fix-network-devices/description
  The OpenWrt 21.02 introduced the new way for configuring network devices. They
  are now configured separatelly and only referenced in network interfaces.
endef

define Package/fix-turris1x-btrfs-sdcard/description
  The fix for Turris 1.x SD card going to read only mode.
  This adds command that forces SD card controller to the RW mode as part of the
  boot process (U-Boot environment).
endef

define Package/fix-i-agree-with-eula-1/description
  The Sentinel EULA agreement. This is used in combination with removal of
  sentinel-i_agree_with_eula and thus switch from forced enable to optional.
  It reenables agreement after package that forced it is removed.
endef

define Package/fix-remote-access-ca-permissions/description
  The fix for incorrect permissions of remote access CA files.
  Mosquitto now runs under it's own dedicated user and fails to start with
  CA files owner by root.
  Change owner of CA files so that mosquitto is able to operate again.
endef

define Package/fix-omnia-leds-migrate/description
  Migrating LED names on Turris Omnia routers from old names to new upstream
  names. Updates both Rainbow and OpenWrt LED config.
endef

define Package/fix-turris1x-leds-migrate/description
  Migrating LED names on Turris 1.x routers from old names to new upstream
  names. Updates both Rainbow and OpenWrt LED config.
endef

define Package/fix-firewall-doublesafe/description
  Under some circumstances, wan ruleset might disappear from firewall. Try
  restarting the firewall to get it back or in worst case, block all incoming
  connections. Better safe then sorry.
endef


$(eval $(call FIX,sentinel-remove-invalid-firewall-rules,+firewall +uci))
$(eval $(call FIX,samba-migrate-to-samba4,+samba4-server +uci))
$(eval $(call FIX,updater-v65.0-alternatives-update,+updater-ng +uci,prerm))
$(eval $(call FIX,dns-forward-quad9-split,+resolver-conf +uci))
$(eval $(call FIX,pkglists-options,+pkglists))
$(eval $(call FIX,uboot-env-reset))
$(eval $(call FIX,updater-rm-log,+updater-ng))
$(eval $(call FIX,config-foris-restore,+foris-controller +schnapps))
$(eval $(call FIX,all-lan-ports-in-lan,+uci +netifd))
$(eval $(call FIX,corrupted-contract-by-rescue,+uboot-envtools))
$(eval $(call FIX,cleanup-cert-backup,+cert-backup))
$(eval $(call FIX,edns-buffer-size,+resolver-conf +uci))
$(eval $(call FIX,dhparam-to-cagen,+uci +turris-cagen))
$(eval $(call FIX,pkglists-hardening-options,+pkglists +uci))
$(eval $(call FIX,nor-update,+turris-nor-update +turris-nor-update-firmware))
$(eval $(call FIX,nextcloud-conf,+nextcloud))
$(eval $(call FIX,sentinel-nikola-to-fwlogs,+sentinel-proxy))
$(eval $(call FIX,pkglists-nikola-to-fwlogs,+pkglists))
$(eval $(call FIX,lighttpd-sync-with-upstream,+lighttpd))
$(eval $(call FIX,firewall-zone-limit,+firewall))
$(eval $(call FIX,network-devices,+netifd))
$(eval $(call FIX,turris1x-btrfs-sdcard,+pkglists))
$(eval $(call FIX,i-agree-with-eula-1,+uci,prerm))
$(eval $(call FIX,remote-access-ca-permissions,+turris-cagen +foris-controller))
$(eval $(call FIX,omnia-leds-migrate,+rainbow @TARGET_mvebu_cortexa9_DEVICE_cznic_turris-omnia))
$(eval $(call FIX,turris1x-leds-migrate,+rainbow @TARGET_mpc85xx_p2020_DEVICE_cznic_turris1x))
$(eval $(call FIX,firewall-doublesafe))
