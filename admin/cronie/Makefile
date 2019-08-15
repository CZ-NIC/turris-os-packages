#
## Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=cronie
PKG_VERSION:=1.5.4
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/cronie-crond/cronie/archive
PKG_HASH:=87661b49269c82d437156921fd3385dae14cb316071aa7903faa00a5ea05c13f
PKG_LICENSE:=MIT
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

PKG_BUILD_DIR:=$(BUILD_DIR)/cronie-cronie-$(PKG_VERSION)
PKG_INSTALL:=1
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/autotools.mk

define Package/$(PKG_NAME)
  SECTION:=admin
  CATEGORY:=Administration
  TITLE:=Cronie standard Unix crond
  URL:=https://github.com/cronie-crond/cronie
  DEPENDS:=@(!BUSYBOX_CONFIG_CROND&&!BUSYBOX_CONFIG_CRONTAB)
  USERID:=cron=16:cron=16
endef

define Package/$(PKG_NAME)/description
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
	--with-daemon_groupname=cron

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/crontab $(1)/usr/bin/crontab
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/cronnext $(1)/usr/bin/cronnext
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/crond $(1)/usr/sbin/crond
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/cron.init $(1)/etc/init.d/cron

	$(INSTALL_DIR) $(1)/etc/cron.d
	touch $(1)/etc/cron.d/.keep
	$(INSTALL_DIR) $(1)/etc/crontabs
	touch $(1)/etc/crontabs/.keep
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
