#
## Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=logsend
PKG_VERSION:=26
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=ssh://git@git.nic.cz/router/misc
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=7d7db9871f670271f4309d213c9fec35aacdf6ec
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Michal Vaner <michal.vaner@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+vixie-cron +curl +libopenssl +libatsha204 +cznic-cacert-bundle +syslog-ng3
endef

define Build/Compile
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR)/logsend $(MAKE_FLAGS)
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/logsend/logsend.sh $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/logsend/whatsnew $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/cron.d
	$(CP) $(PKG_BUILD_DIR)/logsend/logsend.cron $(1)/etc/cron.d/logsend
	chmod 0600 $(1)/etc/cron.d/logsend
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
