#
## Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=updater
PKG_VERSION:=43
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=ssh://git@git.nic.cz/router/misc
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=7d7db9871f670271f4309d213c9fec35aacdf6ec
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Michal Vaner <michal.vaner@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

ifeq ($(CONFIG_TARGET_mpc85xx_p2020_nand_TURRISNAND),y)

TURRIS_DEPS:=+cert-backup

define Package/$(PKG_NAME)/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
/usr/sbin/cert-backup /usr/share/updater/keys/release.pem /etc/ssl/updater.pem
}
endef

endif

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+vixie-cron +openssl-util +libatsha204 +curl $(TURRIS_DEPS)
endef

# The built is empty. But as there's no makefile in the git repo, we need to
# override the default that runs "make".
define Build/Compile
	true
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/updater/updater.sh $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/updater/updater-wipe.sh $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/usr/share/updater/keys
	$(CP) $(PKG_BUILD_DIR)/updater/updater-standby.pub.pem $(1)/usr/share/updater/keys/release.pem

	$(INSTALL_DIR) $(1)/etc/cron.d
	$(CP) $(PKG_BUILD_DIR)/updater/updater.cron $(1)/etc/cron.d/updater
	chmod 0600 $(1)/etc/cron.d/updater

	$(INSTALL_DIR) $(1)/etc/ssl
	$(CP) $(PKG_BUILD_DIR)/cacerts/startcom.pem $(1)/etc/ssl/updater.pem
endef

define Package/updater-testkey
	TITLE:=updater-testkey
endef

define Package/updater-testkey/install
	$(INSTALL_DIR) $(1)/usr/share/updater/keys
	$(CP) $(PKG_BUILD_DIR)/updater/updater.pub.pem $(1)/usr/share/updater/keys/test.pem
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
$(eval $(call BuildPackage,updater-testkey))
