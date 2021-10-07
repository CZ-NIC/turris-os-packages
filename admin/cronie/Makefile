#
## Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=cronie
PKG_VERSION:=1.5.7
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/cronie-crond/cronie/archive
PKG_HASH:=30190b791c79bd72a43eb7cd6fced00be850e2e27e60852dec6dbacb82ecf21e

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=ISC
PKG_LICENSE_FILES:=COPYING

PKG_BUILD_DIR:=$(BUILD_DIR)/cronie-cronie-$(PKG_VERSION)
PKG_INSTALL:=1
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/autotools.mk

define Package/cronie
  SECTION:=admin
  CATEGORY:=Administration
  TITLE:=Cronie standard Unix crond
  URL:=https://github.com/cronie-crond/cronie
  DEPENDS:=@(!BUSYBOX_CONFIG_CROND&&!BUSYBOX_CONFIG_CRONTAB)
  USERID:=cron=16:cron=16
endef

define Package/cronie/description
  Cronie contains the standard UNIX daemon crond that runs specified programs at
  scheduled times and related tools. It is based on the original cron and has
  security and configuration enhancements like the ability to use pam and SELinux.
endef

CONFIGURE_ARGS += \
	--enable-syscrontab \
	--without-selinux \
	--without-pam \
	--with-inotify \
	--with-daemon_username=cron \
	--with-daemon_groupname=cron \
	--disable-anacron
CONFIGURE_VARS += \
		SPOOL_DIR=/var/spool/cron/crontabs

define Package/cronie/conffiles
/etc/config/cronie
endef

define Package/cronie/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/crontab $(1)/usr/bin/crontab
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/cronnext $(1)/usr/bin/cronnext
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/crond $(1)/usr/sbin/crond
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/cron.init $(1)/etc/init.d/cron
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_BIN) ./files/cronie.uci $(1)/etc/config/cronie

	$(INSTALL_DIR) $(1)/etc/cron.d
	touch $(1)/etc/cron.d/.keep
	$(INSTALL_DIR) $(1)/etc/crontabs
	touch $(1)/etc/crontabs/.keep
endef

$(eval $(call BuildPackage,cronie))
