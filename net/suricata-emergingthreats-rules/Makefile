#
# Copyright (C) 2019 CZ.NIC, z.s.p.o.
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=suricata-emergingthreats-rules
PKG_VERSION:=5
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/suricata-emergingthreats-rules/Default
  SECTION:=net
  CATEGORY:=Network
endef

define Package/suricata-emergingthreats-rules
$(call Package/suricata-emergingthreats-rules/Default)
  TITLE:=IDS
  DEPENDS:=+suricata-pakon
endef

define Package/suricata-emergingthreats-rules-ludus
$(call Package/suricata-emergingthreats-rules/Default)
  TITLE:=IDS
  DEPENDS:=+suricata-bin
endef

define Build/Compile
	true
endef

define Package/suricata-emergingthreats-rules/install/Default
	$(INSTALL_DIR) $(1)/etc/cron.d
	$(INSTALL_BIN) ./files/suricata.cron $(1)/etc/cron.d/suricata

	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/update_rules.sh $(1)/usr/bin/suricata_update_rules.sh

	$(INSTALL_DIR) $(1)/etc/logrotate.d/
	$(INSTALL_CONF) ./files/logrotate.conf $(1)/etc/logrotate.d/suricata-alert
endef

define Package/suricata-emergingthreats-rules/install
	$(call Package/suricata-emergingthreats-rules/install/Default)
	$(INSTALL_DIR) $(1)/etc/suricata-pakon/conf.d
	$(INSTALL_CONF) ./files/rules.yaml $(1)/etc/suricata-pakon/conf.d/rules.yaml

	$(INSTALL_DIR) $(1)/etc/suricata-pakon/output_conf.d
	$(INSTALL_CONF) ./files/alert.yaml $(1)/etc/suricata-pakon/output_conf.d/alert.yaml
endef

define Package/suricata-emergingthreats-rules-ludus/install
	$(call Package/suricata-emergingthreats-rules/install/Default)
endef

define Package/suricata-emergingthreats-rules/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	/etc/init.d/suricata-pakon restart
}
endef

define Package/suricata-emergingthreats-rules/postrm
#!/bin/sh
	/etc/init.d/suricata-pakon restart
endef


$(eval $(call BuildPackage,suricata-emergingthreats-rules))
$(eval $(call BuildPackage,suricata-emergingthreats-rules-ludus))

