#
# Copyright (C) 2017-2020 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=suricata-conntrack-flows
PKG_VERSION:=1
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/suricata_conntrack_flows.git
PKG_MIRROR_HASH:=26f47e884cd3db5ce9498d954fef00da2fd799fa9ee05ddc50524623673113a5
PKG_SOURCE_VERSION:=a4fe20378c2451171b143511529179ae1d796dde

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later

PKG_INSTALL:=0

include $(INCLUDE_DIR)/package.mk

define Package/suricata-conntrack-flows
  SECTION:=collect
  CATEGORY:=Collect
  TITLE:=Suricata Conntrack Flows - helper script
  DEPENDS:=+python3-light
endef

define Package/suricata-conntrack-flows/description
  Helper script to track flows bypassed by suricata.
endef

Build/Compile:=:
Build/Install:=:

define Package/suricata-conntrack-flows/install
	$(INSTALL_DIR) $(1)/usr/libexec
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/suricata_conntrack_flows.py $(1)/usr/libexec/
endef

define Package/suricata-conntrack-flows/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	grep "max_dgram_qlen" /etc/sysctl.conf || printf "\nnet.unix.max_dgram_qlen=100" >> /etc/sysctl.conf
}
endef

$(eval $(call BuildPackage,suricata-conntrack-flows))
