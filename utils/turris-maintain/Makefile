#
## Copyright (C) 2019-2021 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-maintain
PKG_VERSION:=13
PKG_RELEASE:=$(AUTORELEASE)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/Common
  SECTION:=utils
  CATEGORY:=Utilities
endef

define Package/turris-backup
  $(call Package/Common)
  TITLE:=Turris backup scripts
  DEPENDS:=+uci +coreutils-base64 +bzip2 +tar
endef

define Package/turris-restart
  TITLE:=Turris restart utility scripts
  DEPENDS:=+uci +python3 +python3-uci +coreutils-base64 +bzip2 +crypto-wrapper
endef

define Package/turris-maintain
  $(call Package/Common)
  TITLE:=Turris maintain scripts
  DEPENDS:=+turris-backup +turris-restart
endef

define Package/turris-backup/description
 Contains a couple of scripts which are resposible for storing/restoring backups.
endef

define Package/turris-restart/description
 Scripts that are used to distribute notice about reboot and specific services
 restart to Turris components.
endef

define Package/turris-backup/conffiles
/etc/config/backups
endef

define Package/turris-backup/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/config-backup.sh $(1)/usr/bin/turris-backup
	$(INSTALL_BIN) ./files/config-restore.sh $(1)/usr/bin/turris-backup-restore
	ln -sf ./turris-backup $(1)/usr/bin/maintain-config-backup
	ln -sf ./turris-backup-restore $(1)/usr/bin/maintain-config-restore

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/backups.uci $(1)/etc/config/backups
endef

define Package/turris-restart/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/reboot-needed.sh $(1)/usr/bin/maintain-reboot-needed
	$(INSTALL_BIN) ./files/reboot.py $(1)/usr/bin/maintain-reboot
	$(INSTALL_BIN) ./files/network-restart.py $(1)/usr/bin/maintain-network-restart
	$(INSTALL_BIN) ./files/lighttpd-restart.py $(1)/usr/bin/maintain-lighttpd-restart
endef

Package/turris-maintain/install:=:
Build/Compile:=:

$(eval $(call BuildPackage,turris-backup))
$(eval $(call BuildPackage,turris-restart))
$(eval $(call BuildPackage,turris-maintain))
