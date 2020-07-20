#
# Copyright (C) 2017 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=suricata-conntrack-flows
PKG_VERSION:=1
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/suricata_conntrack_flows.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=a4fe20378c2451171b143511529179ae1d796dde
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_MAINTAINER:=Martin Petracek <martin.petracek@nic.cz>
PKG_LICENSE:=GPL-3.0

PKG_INSTALL:=0

include $(INCLUDE_DIR)/package.mk

define Package/suricata-conntrack-flows
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Helper script to track flows bypassed by suricata
	TITLE:=suricata_conntrack flows
	DEPENDS:=+python3-light
endef

define Package/$(PKG_NAME)/description
  Helper script to track flows bypassed by suricata.
endef

define Build/Compile
  true
endef

define Build/Install
  true
endef


define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/libexec
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/suricata_conntrack_flows.py $(1)/usr/libexec/
endef

define Package/suricata/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	grep "max_dgram_qlen" /etc/sysctl.conf || printf "\nnet.unix.max_dgram_qlen=100" >> /etc/sysctl.conf
}
endef


$(eval $(call BuildPackage,$(PKG_NAME)))
