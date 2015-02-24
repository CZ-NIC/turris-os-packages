#
## Copyright (C) 2014 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=user_notify
PKG_VERSION:=32
PKG_SOURCE_SUBDIR:=$(PKG_NAME)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/misc.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=db4cb6177999bd12234378e334ba75c51e3a5779
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_MAINTAINER:=Michal Vaner <michal.vaner@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/user_notify
	TITLE:=user_notify
	DEPENDS:=+at +msmtp +create_notification
endef

define Build/Compile
	true
endef

define Package/user_notify/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/user_notify.config $(1)/etc/config/user_notify
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mail_notifier/notifier $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mail_notifier/user-notify-cleaner $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mail_notifier/user-notify-display $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc/cron.d/
	$(INSTALL_DATA) ./files/user_notify.cron $(1)/etc/cron.d/notifier
endef

define Package/user_notify/conffiles
/etc/config/user_notify
endef

define Package/create_notification
	TITLE:=create_notification
endef

define Package/create_notification/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mail_notifier/create_notification $(1)/usr/bin/
endef

$(eval $(call BuildPackage,user_notify))
$(eval $(call BuildPackage,create_notification))
