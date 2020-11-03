#
## Copyright (C) 2013-2020 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=cznic-cacert-bundle
PKG_VERSION:=38
PKG_RELEASE:=4
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/misc.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=1496ca959d1b51c2e98d623363e1fd9eba464d27
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

TURRIS_DEPS:=+cert-backup

define Package/$(PKG_NAME)/postinst
#!/bin/sh

[ -n "$$IPKG_INSTROOT" ] || {
	# TODO: If ever anything gets removed from this list, use -r, not delete it manually.
	/usr/sbin/cert-backup \
		/etc/ssl/turris.pem \
		/etc/ssl/ucollect-server.pem \
		-r /usr/bin/get-api-crl \
		-r /etc/ssl/www_turris_cz_ca.pem \
		-r /etc/ssl/startcom.pem \
		-r /etc/ssl/api.turris.pem
	get-api-crl
}
endef

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+cert-backup +c-rehash
endef

# The built is empty. But as there's no makefile in the git repo, we need to
# override the default that runs "make".
define Build/Compile
	true
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/ssl/
	# TODO: If anything is modified here, it needs to be updated in the postinst too
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/cacerts/emergency-ca/ca.crt $(1)/etc/ssl/turris.pem
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/cacerts/ucollect-server.pem $(1)/etc/ssl/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
