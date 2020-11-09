#
## Copyright (C) 2019-2020 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-maintain
PKG_VERSION:=11
PKG_RELEASE:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/turris-maintain
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Turris maintain scripts
  DEPENDS:=+uci +python3 +python3-uci +coreutils-base64 +bzip2 +crypto-wrapper
endef

define Package/turris-maintain/description
 Contains a couple of scripts which are resposible for storing/restoring backups.
endef

define Package/turris-maintain/conffiles
/etc/config/backups
endef

define Package/turris-maintain/install
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

Build/Compile:=:

$(eval $(call BuildPackage,turris-maintain))
