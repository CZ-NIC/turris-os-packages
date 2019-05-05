#
## Copyright (C) 2018-2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=user-notify
PKG_VERSION:=61
PKG_RELEASE:=1
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/user-notify.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/user-notify
	TITLE:=user-notify
	DEPENDS:=+at +msmtp +ca-certificates +crypto-wrapper +sentinel-certgen +create_notification
endef

define Build/Compile
	true
endef

define Package/user-notify/install
	cd $(PKG_BUILD_DIR); $(MAKE) DESTDIR="$(1)" install_scripts install_aux
	rm $(1)/usr/bin/create_notification
endef

define Package/user-notify/conffiles
/etc/config/user_notify
endef

define Package/create_notification
	TITLE:=create_notification
endef

define Package/create_notification/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/scripts/create_notification $(1)/usr/bin/
endef

$(eval $(call BuildPackage,user-notify))
$(eval $(call BuildPackage,create_notification))
