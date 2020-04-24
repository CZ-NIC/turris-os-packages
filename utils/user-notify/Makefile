#
## Copyright (C) 2018-2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=user-notify
PKG_VERSION:=61.3
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/user-notify.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later

include $(INCLUDE_DIR)/package.mk

define Package/user-notify
  TITLE:=Turris user notifications
  DEPENDS:=+at +msmtp +ca-certificates +crypto-wrapper +sentinel-certgen +gettext-tools +create_notification
endef

Build/Compile:=:

define Package/user-notify/install
	cd $(PKG_BUILD_DIR); $(MAKE) DESTDIR="$(1)" install_scripts install_aux
	rm $(1)/usr/bin/create_notification
endef

define Package/user-notify/conffiles
/etc/config/user_notify
endef


define Package/create_notification
  TITLE:=Create Turris user notification
  DEPENDS:=+gettext-tools
endef

define Package/create_notification/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/scripts/create_notification $(1)/usr/bin/
endef

$(eval $(call BuildPackage,user-notify))
$(eval $(call BuildPackage,create_notification))
