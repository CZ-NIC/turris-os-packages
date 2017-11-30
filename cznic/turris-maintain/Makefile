#
## Copyright (C) 2017 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-maintain
PKG_VERSION:=1
PKG_MAINTAINER:=Stepan Henek <stepan.henek@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+uci
endef

define Package/$(PKG_NAME)/description
 Contains a couple of scripts which are resposible for storing/restoring backups.
endef

# The built is empty. But as there's no makefile in the git repo, we need to
# override the default that runs "make".
define Build/Compile
	true
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) files/config-backup.sh $(1)/usr/bin/maintain-config-backup
	$(INSTALL_BIN) files/config-restore.sh $(1)/usr/bin/maintain-config-restore
	$(INSTALL_BIN) files/reboot-needed.sh $(1)/usr/bin/maintain-reboot-needed
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
