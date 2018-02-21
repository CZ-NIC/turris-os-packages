#
## Copyright (C) 2018 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=user_notify
PKG_VERSION:=50
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/user-notify.git
PKG_SOURCE_VERSION:=2a1bb31a04a33937c017515c44e640cec78a2e49
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/user_notify
	TITLE:=user_notify
	DEPENDS:=+at +msmtp +create_notification
endef

define Package/user_notify_locales
	TITLE:=user_notify_locales
	DEPENDS:=+gettext
endef

define Build/Compile
	true
endef

define Package/user_notify/install
	cd $(PKG_BUILD_DIR); $(MAKE) DESTDIR="$(1)" install_scripts install_aux
	rm $(1)/usr/bin/create_notification
endef

define Package/user_notify_locales/install
	cd $(PKG_BUILD_DIR); $(MAKE) DESTDIR="$(1)" install_langs
endef

define Package/user_notify/conffiles
/etc/config/user_notify
endef

define Package/create_notification
	TITLE:=create_notification
endef

define Package/create_notification/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/scripts/create_notification $(1)/usr/bin/
endef

$(eval $(call BuildPackage,user_notify))
$(eval $(call BuildPackage,create_notification))
$(eval $(call BuildPackage,user_notify_locales))
