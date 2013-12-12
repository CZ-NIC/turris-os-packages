#
## Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=nikola
PKG_VERSION:=12
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=ssh://git@git.nic.cz/router/nikola
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=8f862aae59ea647975be6cf60bd30210a7748dff
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Martin Strbacka <martin.strbacka@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+python +logrotate +syslog-ng3 +python-libatsha204 +python-openssl
endef

define Build/Compile
	cd $(PKG_BUILD_DIR)/Nikola ; $(CONFIGURE_VARS) python ./setup.py install --prefix="$(PKG_INSTALL_DIR)/usr"
endef

define Package/$(PKG_NAME)/conffiles
/etc/config/nikola
/etc/logrotate.d/iptables
/etc/cron.d/nikola
/etc/syslog-ng.d/nikola.conf
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)
	$(CP) $(PKG_INSTALL_DIR)/* $(1)/
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/conf/uci/nikola $(1)/etc/config/nikola
	$(INSTALL_DIR) $(1)/etc/logrotate.d/
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/conf/logrotate.d/iptables $(1)/etc/logrotate.d/iptables
	$(INSTALL_DIR) $(1)/usr/share/nikola/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/conf/cron/nikola.sh $(1)/usr/share/nikola/bin/nikola.sh
	$(INSTALL_DIR) $(1)/etc/cron.d
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/conf/cron/nikola $(1)/etc/cron.d/nikola
	$(INSTALL_DIR) $(1)/etc/syslog-ng.d/
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/conf/syslog/syslog-ng.conf $(1)/etc/syslog-ng.d/nikola.conf
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
