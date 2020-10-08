#
## Copyright (C) 2019-2020 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=fosquitto
PKG_VERSION:=20
PKG_RELEASE:=6

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/fosquitto
  SECTION:=web
  CATEGORY:=Web
  SUBMENU:=Foris Controller
  TITLE:=fosquitto
  DEPENDS:=+mosquitto-ssl +mosquitto-client-ssl
endef

define Package/fosquitto/description
  Instance of mosquitto server used as foris message bus.
endef

Build/Compile:=:

define Package/fosquitto/conffiles
/etc/config/fosquitto
endef

define Package/fosquitto/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/fosquitto.init $(1)/etc/init.d/fosquitto

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/fosquitto.uci $(1)/etc/config/fosquitto
endef

define Package/fosquitto/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
	# run scripts to update files
	/etc/init.d/fosquitto enable
	/etc/init.d/fosquitto restart
}
endef

define Package/fosquitto-monitor
  SECTION:=web
  CATEGORY:=Web
  SUBMENU:=Foris Controller
  TITLE:=fosquitto-monitor
  DEPENDS:=+fosquitto
endef

define Package/fosquitto-monitor/description
  Script to monitor fosquitto messages.
endef

define Package/fosquitto-monitor/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/fosquitto-monitor.py $(1)/usr/bin/fosquitto-monitor
endef

$(eval $(call BuildPackage,fosquitto))
$(eval $(call BuildPackage,fosquitto-monitor))
