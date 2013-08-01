#
## Copyright (C) 2013 CZ.NIC z.s.p.o. <michal.vaner@nic.cz>
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=daemon-watchdog
PKG_VERSION:=2
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=ssh://git@git.nic.cz/router/misc
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=3dd6692d385d631d57f6e32f70d9ec4628811bd4
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Michal Vaner <michal.vaner@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/daemon-watchdog
	TITLE:=daemon-watchdog
	DEPENDS:=+vixie-cron
endef

# The built is empty. But as there's no makefile in the git repo, we need to
# override the default that runs "make".
define Build/Compile
	true
endef

define Package/daemon-watchdog/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/watchdog/watchdog.sh $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/cron.d
	$(CP) $(PKG_BUILD_DIR)/watchdog/watchdog.cron $(1)/etc/cron.d/watchdog
	chmod 0600 $(1)/etc/cron.d/watchdog
endef

$(eval $(call BuildPackage,daemon-watchdog))
