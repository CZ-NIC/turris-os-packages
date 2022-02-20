#
## Copyright (C) 2013-2020 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=cert-backup
PKG_VERSION:=14
PKG_RELEASE:=2

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=BSD-3-Clause

include $(INCLUDE_DIR)/package.mk

define Package/Common
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Certificates backuper
  DEPENDS:=+mount-utils
endef

define Package/cert-backup
  $(call Package/Common)
  DEPENDS+=+cert-backup-backend
endef

define Package/CommonBackend
  $(call Package/Common)
  PROVIDES:=cert-backup-backend
endef

define Package/cert-backup-btrfs
  $(call Package/CommonBackend)
  TITLE+= - Btrfs backend
  DEPENDS+=+btrfs-progs
endef

define Package/cert-backup-turris1x
  $(call Package/CommonBackend)
  TITLE+= - Turris 1.x backend
  DEPENDS:=@TARGET_mpc85xx_p2020_DEVICE_cznic_turris1x
  CONFLICTS:=cert-backup-btrfs
endef

define Package/cert-backup/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) ./files/cert-backup $(1)/usr/sbin/
endef

define Package/cert-backup-btrfs/install
	$(INSTALL_DIR) $(1)/usr/share/cert-backup
	$(INSTALL_DATA) ./files/btrfs_backend.sh $(1)/usr/share/cert-backup/backend.sh
endef

define Package/cert-backup-turris1x/install
	$(INSTALL_DIR) $(1)/usr/share/cert-backup
	$(INSTALL_DATA) ./files/turris1x_backend.sh $(1)/usr/share/cert-backup/backend.sh
endef

Build/Compile:=:

$(eval $(call BuildPackage,cert-backup))
$(eval $(call BuildPackage,cert-backup-btrfs))
$(eval $(call BuildPackage,cert-backup-turris1x))
