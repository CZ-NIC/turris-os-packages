#
## Copyright (C) 2017 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=pakon-lists
PKG_VERSION:=5
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/pakon-light-lists.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
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

	$(INSTALL_DATA) $(PKG_BUILD_DIR)/domains_replace/dist.conf $(1)/usr/share/pakon-light/domains_replace/

	$(INSTALL_DATA) $(PKG_BUILD_DIR)/domains_ignore/ads.txt $(1)/usr/share/pakon-light/domains_ignore/dist_ads.txt
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/domains_ignore/rubbish.txt $(1)/usr/share/pakon-light/domains_ignore/dist_rubbish.txt
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/domains_ignore/ocsp.txt $(1)/usr/share/pakon-light/domains_ignore/dist_ocsp.txt
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/domains_ignore/cdn.txt $(1)/usr/share/pakon-light/domains_ignore/dist_cdn.txt
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	/usr/bin/python3 /usr/libexec/pakon-light/domains_reapply.py
	/etc/init.d/pakon-monitor restart
	/etc/init.d/pakon-handler restart
}
endef


$(eval $(call BuildPackage,$(PKG_NAME)))
