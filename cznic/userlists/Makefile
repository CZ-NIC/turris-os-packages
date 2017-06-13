#
## Copyright (C) 2016 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=userlists
PKG_VERSION:=7
PKG_MAINTAINER:=Michal Vaner <michal.vaner@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/userlists
	TITLE:=Userlists for the updater
endef

define Build/Compile
	true
endef

BRAND?=turris
ifeq ($(CONFIG_TARGET_mvebu_Turris-Omnia),y)
BRAND:=omnia
endif

define Package/userlists/install
	$(INSTALL_DIR) $(1)/usr/share/updater/
	$(INSTALL_DATA) ./files/definitions-$(BRAND) $(1)/usr/share/updater/definitions
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
