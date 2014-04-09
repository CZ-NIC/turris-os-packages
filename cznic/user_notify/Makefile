#
## Copyright (C) 2014 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=user_notify
PKG_VERSION:=16
PKG_SOURCE_SUBDIR:=$(PKG_NAME)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/misc.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=d4b2c223190a2f5751e41cbe791c6a3f42410948
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_MAINTAINER:=Michal Vaner <michal.vaner@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+at +msmtp
endef

define Build/Compile
	true
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/user_notify.config $(1)/etc/config/user_notify
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mail_notifier/notifier $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mail_notifier/create_notification $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mail_notifier/user-notify-cleaner $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mail_notifier/user-notify-display $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc/cron.d/
	$(INSTALL_DATA) ./files/user_notify.cron $(1)/etc/cron.d/notifier
endef

define Package/$(PKG_NAME)/conffiles
/etc/config/user_notify
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
