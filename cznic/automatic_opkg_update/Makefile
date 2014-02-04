#
## Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=automatic_opkg_update
PKG_VERSION:=1
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Martin Strbacka <martin.strbacka@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+vixie-cron
endef

define Build/Compile
	echo Building OK
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/cron.d
	$(INSTALL_CONF) ./files/automatic_opkg_update.cron $(1)/etc/cron.d/automatic_opkg_update
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
