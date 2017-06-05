#
## Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=vixie-cron
PKG_VERSION:=7
PKG_RELEASE:=3
PKG_SOURCE_URL:=ftp://ftp.isc.org/isc/cron/
PKG_SOURCE_VERSION:=4.1
PKG_SOURCE:=cron_$(PKG_SOURCE_VERSION).shar
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Martin Strbacka <martin.strbacka@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:= +syslog-ng3 @(!BUSYBOX_CONFIG_CROND&&!BUSYBOX_CONFIG_CRONTAB)
	PROVIDES:=cron
endef

define Build/Prepare
	(cp $(DL_DIR)/$(PKG_SOURCE) $(PKG_BUILD_DIR)/$(PKG_SOURCE); cd $(PKG_BUILD_DIR); /bin/sh $(PKG_SOURCE) );
	patch -p1 -d $(PKG_BUILD_DIR) < $(PATCH_DIR)/001*
	patch -p1 -d $(PKG_BUILD_DIR) < $(PATCH_DIR)/002*
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/cron enable
/etc/init.d/cron restart
}
endef

define Package/$(PKG_NAME)/prerm
#!/bin/sh
/etc/init.d/cron disable
/etc/init.d/cron stop
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/cron.init $(1)/etc/init.d/cron
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/cron  $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/crontab  $(1)/usr/bin
	$(INSTALL_DIR) $(1)/etc/cron.d
	$(INSTALL_CONF) ./files/.keep $(1)/etc/cron.d/.keep
	$(INSTALL_DIR) $(1)/etc/crontabs
	$(INSTALL_CONF) ./files/.keep $(1)/etc/crontabs/.keep
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
