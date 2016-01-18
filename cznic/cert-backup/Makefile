#
## Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=cert-backup
PKG_VERSION:=4
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/misc.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=80cbfba2f4597c069a5b7e062d80efac34b59553
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

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/cert-backup/cert-backup $(1)/usr/sbin/
endef

else
define Build/Compile
	echo "The target board does not have a backup partition."
endef

# We install an empty file instead of the cert-backup script, so not to damage things
define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/cert-backup/cert-backup $(1)/usr/sbin/
	echo ''>$(1)/usr/sbin/cert-backup
endef
endif

$(eval $(call BuildPackage,$(PKG_NAME)))
