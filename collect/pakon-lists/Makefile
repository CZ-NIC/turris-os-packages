#
## Copyright (C) 2017-2019 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=pakon-lists
PKG_VERSION:=6
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/pakon-light-lists.git
PKG_SOURCE_VERSION:=a0afbc6604d55915b7246ac7e15bd65757b0f57f

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/pakon-lists
	TITLE:=Pakon lists
endef

Build/Compile:=:

define Package/pakon-lists/install
	$(INSTALL_DIR) $(1)/usr/share/pakon-light/domains_ignore/
	$(INSTALL_DIR) $(1)/usr/share/pakon-light/domains_replace/

	$(INSTALL_DATA) $(PKG_BUILD_DIR)/domains_replace/dist.conf $(1)/usr/share/pakon-light/domains_replace/

	$(INSTALL_DATA) $(PKG_BUILD_DIR)/domains_ignore/ads.txt $(1)/usr/share/pakon-light/domains_ignore/dist_ads.txt
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/domains_ignore/rubbish.txt $(1)/usr/share/pakon-light/domains_ignore/dist_rubbish.txt
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/domains_ignore/ocsp.txt $(1)/usr/share/pakon-light/domains_ignore/dist_ocsp.txt
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/domains_ignore/cdn.txt $(1)/usr/share/pakon-light/domains_ignore/dist_cdn.txt
endef

define Package/pakon-lists/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	/usr/bin/python3 /usr/libexec/pakon-light/domains_reapply.py
	/etc/init.d/pakon-monitor restart
	/etc/init.d/pakon-handler restart
}
endef

$(eval $(call BuildPackage,pakon-lists))
