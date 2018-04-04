#
# Copyright (C) 2017 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=sentinel-dynfw-client
PKG_VERSION:=1
PKG_RELEASE:=1
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git@gitlab.labs.nic.cz:turris/sentinel/dynfw.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=acecf694d1e922c6c9fc599cb0313a409a167e27
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_MAINTAINER:=Martin Petracek <martin.petracek@nic.cz>
PKG_LICENSE:=GPL-3.0

PKG_INSTALL:=0

include $(INCLUDE_DIR)/package.mk

define Package/sentinel-dynfw-client
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Receives updates of firewall rules and updates firewall accordingly
	TITLE:=Sentinel dynamic firewall client
	DEPENDS:=+python3-light +ipset +python3-msgpack
endef

define Package/$(PKG_NAME)/description
  Sentinel dynamic firewall client
endef

define Build/Compile
  true
endef

define Build/Install
  true
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) files/sentinel-dynfw-client.init $(1)/etc/init.d/sentinel-dynfw-client
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/dynfw_client.py $(1)/usr/bin/sentinel-dynfw-client
endef

define Package/sentinel-dynfw-client/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
        # migrate configuration
	grep "turris-sn-wan-input-block" /etc/firewall.user || {
		echo "/usr/sbin/ipset create turris-sn-wan-input-block hash:ip -exist" >> /etc/firewall.user
		echo "/usr/sbin/iptables -I input_wan_rule -m set --match-set turris-sn-wan-input-block src -j DROP" >> /etc/firewall.user
	}
        /etc/init.d/sentinel-dynfw-client enable
        /etc/init.d/sentinel-dynfw-client restart 2>/dev/null
}
endef

define Package/sentinel-dynfw-client/prerm
#!/bin/sh
	grep -v "turris-sn-wan-input-block" /etc/firewall.user > /etc/firewall.user.tmp && mv /etc/firewall.user.tmp /etc/firewall.user
        /etc/init.d/sentinel-dynfw-client disable
        /etc/init.d/sentinel-dynfw-client stop
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
