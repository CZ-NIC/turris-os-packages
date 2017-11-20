#
## Copyright (C) 2017 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=pakon-light-lists
PKG_VERSION:=1
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/pakon-light-lists.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=0270e9a0f6a111247713f66b8e4f6d71637541df
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Martin Petráček <martin.petracek@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
endef

define Build/Compile
	true
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/share/pakon-light/domains_ignore/
	$(INSTALL_DIR) $(1)/usr/share/pakon-light/domains_replace/

	$(INSTALL_DATA) $(PKG_BUILD_DIR)/domains_replace/dist.conf $(1)/usr/share/pakon-light/domans_replace/

	$(INSTALL_DATA) $(PKG_BUILD_DIR)/domains_ignore/ads_downloaded.txt $(1)/usr/share/pakon-light/domans_ignore/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/domains_ignore/rubbish.txt $(1)/usr/share/pakon-light/domans_ignore/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
