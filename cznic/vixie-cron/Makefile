#
## Copyright (C) 2013 CZ.NIC z.s.p.o. <martin.strbacka@nic.cz>
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=vixie-cron
PKG_VERSION:=4
PKG_SOURCE_URL:=ftp://ftp.isc.org/isc/cron/
PKG_SOURCE_VERSION:=4.1
PKG_SOURCE:=cron_$(PKG_SOURCE_VERSION).shar
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Martin Strbacka <martin.strbacka@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/vixie-cron
	TITLE:=vixie-cron
	DEPENDS:=@BUSYBOX_CONFIG_SYSLOGD @(!BUSYBOX_CONFIG_CROND&&!BUSYBOX_CONFIG_CRONTAB)
endef

define Build/Prepare
	(cp $(DL_DIR)/$(PKG_SOURCE) $(PKG_BUILD_DIR)/$(PKG_SOURCE); cd $(PKG_BUILD_DIR); /bin/sh $(PKG_SOURCE) );
	patch -p1 -d $(PKG_BUILD_DIR) < $(PATCH_DIR)/001*
	patch -p1 -d $(PKG_BUILD_DIR) < $(PATCH_DIR)/002*
endef

define Package/vixie-cron/postinst
#!/bin/sh
[ -d /etc/crontabs ] || mkdir -p /etc/crontabs
[ -d /etc/cron.d ] || mkdir -p /etc/cron.d
/etc/init.d/cron enable
/etc/init.d/cron restart
endef

define Package/vixie-cron/conffiles
/etc/cron.d/
/etc/crontabs
endef

define Package/vixie-cron/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/cron.init $(1)/etc/init.d/cron
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/cron  $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/crontab  $(1)/usr/bin
endef

$(eval $(call BuildPackage,vixie-cron))
