#
## Copyright (C) 2013-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=updater
PKG_VERSION:=109
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/updater.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=1984c36e5cec9feef487379e454f98b8a3d21935
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Michal Vaner <michal.vaner@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

ifeq ($(CONFIG_TARGET_mpc85xx_p2020_nand_TURRISNAND),y)

TURRIS_DEPS:=+cert-backup

endif

define Package/$(PKG_NAME)/postinst
#!/bin/sh
TIME=$$(( $$(tr -cd 0-9 </dev/urandom | head -c 8 | sed -e 's/^0*//' ) % 60 ))
if [ -z "$$TIME" ] ; then
	TIME=0
fi
echo 'MAILTO=""' >"$$IPKG_INSTROOT"/etc/cron.d/updater
echo "$$TIME	*       *       *       *       root	/usr/bin/updater.sh >/dev/null 2>&1 &" >>"$$IPKG_INSTROOT"/etc/cron.d/updater
[ -n "$$IPKG_INSTROOT" ] || {
if [ -x /usr/sbin/cert-backup ] ; then
	/usr/sbin/cert-backup /usr/share/updater/keys/standby.pem /usr/share/updater/keys/release.pem /etc/ssl/updater.pem
fi
if uci get -q updater.pkglists.configured || uci get -q updater.pkglists.lists | grep -q . ; then
	:
else
	uci add_list updater.pkglists.lists=luci-controls
	uci add_list updater.pkglists.lists=nas
	uci add_list updater.pkglists.lists=printserver
	uci add_list updater.pkglists.lists=netutils
fi
uci set updater.pkglists.configured=1
uci commit updater
/etc/init.d/updater enable
true # The previous sometimes returns 1 without any reason. Ignore it.
# No need to start here, it is not a daemon, just a start-up check
}
endef

# It also uses the notifier. But if there's no package that depends on it
# (to send notification) and it is not installed therefore, we can live
# without it.
define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+vixie-cron +openssl-util +libatsha204 +curl $(TURRIS_DEPS) +opkg +bzip2 +cznic-cacert-bundle
endef

# The built is empty. But as there's no makefile in the git repo, we need to
# override the default that runs "make".
define Build/Compile
	true
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/updater.sh $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/updater-wipe.sh $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/updater-resume.sh $(1)/usr/bin/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/updater-utils.sh $(1)/usr/bin/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/updater-worker.sh $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/usr/share/updater/keys
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/updater-standby.pub.pem $(1)/usr/share/updater/keys/standby.pem
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/updater-release.pub.pem $(1)/usr/share/updater/keys/release.pem

	$(INSTALL_DIR) $(1)/etc/cron.d

	$(INSTALL_DIR) $(1)/etc/ssl
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/updater.pem $(1)/etc/ssl/updater.pem

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/updater.config $(1)/etc/config/updater

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/updater.init $(1)/etc/init.d/updater
endef

define Package/$(PKG_NAME)/prerm
#!/bin/sh
/etc/init.d/updater disable
endef

define Package/$(PKG_NAME)/conffiles
/etc/config/updater
endef

define Package/updater-consolidator
	TITLE:=updater-consolidator
	DEPENDS:=python updater
endef

define Package/updater-consolidator/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/updater-remove-pkg.sh $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/updater-consolidate.py $(1)/usr/bin
endef

define Package/updater-testkey
	TITLE:=updater-testkey
endef

define Package/updater-testkey/install
	$(INSTALL_DIR) $(1)/usr/share/updater/keys
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/updater.pub.pem $(1)/usr/share/updater/keys/test.pem
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
$(eval $(call BuildPackage,updater-testkey))
$(eval $(call BuildPackage,updater-consolidator))
