#
## Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-maintain
PKG_VERSION:=10
PKG_RELEASE:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
	
include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+uci +python3 +python3-uci +coreutils-base64 +bzip2 +crypto-wrapper
endef

define Package/$(PKG_NAME)/description
 Contains a couple of scripts which are resposible for storing/restoring backups.
endef

# The built is empty. But as there's no makefile in the git repo, we need to
# override the default that runs "make".
define Build/Compile
	true
endef

define Package/$(PKG_NAME)/conffiles
	/etc/config/backups
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) files/config-backup.sh $(1)/usr/bin/maintain-config-backup
	$(INSTALL_BIN) files/config-restore.sh $(1)/usr/bin/maintain-config-restore
	$(INSTALL_BIN) files/reboot-needed.sh $(1)/usr/bin/maintain-reboot-needed
	$(INSTALL_BIN) files/reboot.py $(1)/usr/bin/maintain-reboot
	$(INSTALL_BIN) files/network-restart.py $(1)/usr/bin/maintain-network-restart
	$(INSTALL_BIN) files/lighttpd-restart.py $(1)/usr/bin/maintain-lighttpd-restart

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/backups.conf $(1)/etc/config/backups
endef

$(eval $(call BuildPackage,turris-maintain))
