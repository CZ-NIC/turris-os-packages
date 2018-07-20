
# Copyright (C) 2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=suricata-pakon
PKG_VERSION:=1
PKG_RELEASE:=7

PKG_LICENSE:=GPL-2.0
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/suricata-pakon
  SECTION:=net
  CATEGORY:=Network
  TITLE:=IDS
  DEPENDS:=+suricata-bin
endef

define Build/Compile
  true
endef

define Build/Install
  true
endef


define Package/suricata-pakon/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/suricata.init $(1)/etc/init.d/suricata-pakon

	$(INSTALL_DIR) $(1)/etc/firewall.d/with_reload
	$(INSTALL_BIN) ./files/suricata.fw $(1)/etc/firewall.d/with_reload/99_suricata_pakon.fw

	$(INSTALL_DIR) $(1)/etc/suricata-pakon
	$(INSTALL_CONF) ./files/suricata.yaml $(1)/etc/suricata-pakon/suricata.yaml

	$(INSTALL_DIR) $(1)/etc/suricata-pakon/output_conf.d
	$(INSTALL_CONF) ./files/output_common.yaml $(1)/etc/suricata-pakon/output_conf.d/common.yaml

	$(INSTALL_DIR) $(1)/etc/suricata-pakon/conf.d
endef


define Package/suricata-pakon/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	/etc/init.d/suricata-pakon enable
	[ -f /etc/init.d/suricata ] && /etc/init.d/suricata stop 2>/dev/null #migration from suricata package, to be removed later
	/etc/init.d/suricata-pakon restart 2>/dev/null
}
endef

define Package/suricata-pakon/prerm
#!/bin/sh
	/etc/init.d/suricata-pakon disable
	/etc/init.d/suricata-pakon stop
endef

$(eval $(call BuildPackage,suricata-pakon))
