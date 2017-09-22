#
# Copyright (C) 2017 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=nextcloud
PKG_VERSION:=12.0.3
PKG_RELEASE:=2

PKG_SOURCE_URL:=https://download.nextcloud.com/server/releases/
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).zip
PKG_MD5SUM:=3f5f7af2eccc2b4f8cd452e0c47b6460

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0

PKG_INSTALL:=0

include $(INCLUDE_DIR)/package.mk

define Package/nextcloud
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Nextcloud server
	DEPENDS=+php7-mod-opcache +php7-fpm +php7-cli +sudo +php7-mod-ctype +php7-mod-fileinfo +php7-mod-xmlreader +php7-mod-openssl +php7-mod-hash +php7-mod-gd +php7-mod-xml +php7-mod-xmlwriter +php7-mod-json +php7-mod-mbstring +php7-mod-pcntl +php7-mod-opcache +php7-mod-session +php7-mod-simplexml +php7-mod-iconv +php7-mod-curl +php7-mod-zip +php7-mod-dom +coreutils-stat +php7 lighttpd-mod-access
endef

define Package/nextcloud-install
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Nextcloud server installation script
	DEPENDS=+nextcloud +mariadb-server +php7-mod-pdo-mysql
endef

define Package/$(PKG_NAME)/description
  A safe home for all your data.
endef

define Package/$(PKG_NAME)_install/description
  Nextcloud is a safe home for all your data. And this is simple installation script.
endef

define Package/$(PKG_NAME)/conffiles
/etc/lighttpd/conf.d/nextcloud.conf
endef

define Build/Compile
endef

define Build/Install
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/srv/www/nextcloud
	for i in `ls -1 $(PKG_BUILD_DIR)`; do \
		expr $$$$i : ipkg || $(CP) -r $(PKG_BUILD_DIR)/$$$$i $(1)/srv/www/nextcloud;\
	done
	$(INSTALL_DIR) $(1)/etc/lighttpd/conf.d/
	$(INSTALL_DATA) ./files/nextcloud.conf $(1)/etc/lighttpd/conf.d/
endef

define Package/$(PKG_NAME)-install/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/easy_install.sh $(1)/usr/bin/nextcloud_install
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
# check if we are on real system
if [ -z "$$IPKG_INSTROOT" ]; then
	if [ -f /srv/www/nextcloud/config/config.php ]; then
		cd /srv/www/nextcloud/
		sudo -u nobody php-cli ./occ upgrade --no-app-disable --no-interaction
	fi
fi
chown -R nobody "$$IPKG_INSTROOT"/srv/www/nextcloud/
endef

$(eval $(call BuildPackage,nextcloud))
$(eval $(call BuildPackage,nextcloud-install))
