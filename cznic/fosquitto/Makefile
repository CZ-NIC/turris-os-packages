#
## Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=fosquitto
PKG_VERSION:=20
PKG_RELEASE:=2
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+mosquitto-ssl +mosquitto-client-ssl
endef

define Package/$(PKG_NAME)/description
	Instance of mosquitto server used as foris message bus
endef

# The built is empty. But as there's no makefile in the git repo, we need to
# override the default that runs "make".
define Build/Compile
	true
endef

define Package/$(PKG_NAME)/conffiles
/etc/config/fosquitto
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/fosquitto.init $(1)/etc/init.d/fosquitto

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/fosquitto.uci $(1)/etc/config/fosquitto
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
	# run scripts to update files
	/etc/init.d/fosquitto enable
	/etc/init.d/fosquitto restart
}
endef

define Package/$(PKG_NAME)-monitor
	TITLE:=$(PKG_NAME)-monitor
	DEPENDS:=+$(PKG_NAME)
endef

define Package/$(PKG_NAME)-monitor/description
	Script to monitor fosquitto messages
endef

define Package/$(PKG_NAME)-monitor/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/fosquitto-monitor.py $(1)/usr/bin/fosquitto-monitor
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_NAME)-monitor))
