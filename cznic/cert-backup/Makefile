#
## Copyright (C) 2013 CZ.NIC z.s.p.o. <michal.vaner@nic.cz>
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=cert-backup
PKG_VERSION:=2
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
endef

# The built is empty. But as there's no makefile in the git repo, we need to
# override the default that runs "make".
ifeq ($(CONFIG_TARGET_mpc85xx_p2020_nand_TURRISNAND),y)
define Build/Compile
	true
endef
else
define Build/Compile
	echo "The target board does not have a backup partition.
endef
endif

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/cert-backup/cert-backup $(1)/usr/sbin/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
