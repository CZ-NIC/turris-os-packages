#
## Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=cznic-cacert-bundle
PKG_VERSION:=23
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/misc.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=2c25890f204b1e5c0ae76d9a621256f4846086ca
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
# TODO: If ever anything gets removed from this list, use -r, not delete it manually.
/usr/sbin/cert-backup /etc/ssl/ucollect-server.pem /etc/ssl/startcom.pem /etc/ssl/api.turris.pem
}
endef

endif

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:= $(TURRIS_DEPS) +vixie-cron
endef

# The built is empty. But as there's no makefile in the git repo, we need to
# override the default that runs "make".
define Build/Compile
	true
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/ssl/
	# TODO: If anything is modified here, it needs to be updated in the postinst too
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/cacerts/api.turris.pem $(1)/etc/ssl/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/cacerts/startcom.pem $(1)/etc/ssl/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/cacerts/ucollect-server.pem $(1)/etc/ssl/
	ln -s /tmp/crl.pem $(1)/etc/ssl/crl.pem

	$(INSTALL_DIR) $(1)/etc/ssl/certs
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/cacerts/startcom.pem $(1)/etc/ssl/certs
	c_rehash $(1)/etc/ssl/certs

	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/cacerts/get-api-crl $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/cron.d
	$(INSTALL_DATA) ./files/get-crl.cron $(1)/etc/cron.d/get-api
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh

if [ -z "$${IPKG_INSTROOT}" ] ; then
	get-api-crl
fi
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
