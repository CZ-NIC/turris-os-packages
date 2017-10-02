#
## Copyright (C) 2013-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=daemon-watchdog
PKG_VERSION:=18
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/misc.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=889940e1a298efe32b6ce3eb9c1c5d0d1b05e3e5
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+vixie-cron
endef

# The built is empty. But as there's no makefile in the git repo, we need to
# override the default that runs "make".
define Build/Compile
	true
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/watchdog/watchdog.sh $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/cron.d
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/watchdog/watchdog.cron $(1)/etc/cron.d/watchdog
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
