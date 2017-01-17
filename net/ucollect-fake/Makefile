#
## Copyright (C) 2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#

include ../ucollect-prog/Makefile.common

VERSION:=23

$(eval $(call UCOLLECT_BASE,ucollect-fake,$(VERSION)))

define Package/ucollect-fake
	SECTION:=net
	CATEGORY:=Network
	TITLE:=The fake servers plugin for ucollect
	DEPENDS:=+ucollect-prog +kmod-ipt-tproxy +iptables-mod-tproxy +ip6tables-mod-nat +syslog-ng3
endef

define Package/ucollect-fake/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/ucollect reload
/etc/init.d/syslog-ng reload
/etc/init.d/firewall reload
}
endef

define Package/ucollect-fake/postrm
#!/bin/sh
/etc/init.d/ucollect reload
/etc/init.d/syslog-ng reload
/etc/init.d/firewall reload
endef

define Package/ucollect-fake/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lib/libplugin_fake.so $(1)/usr/lib/libplugin_ucollect_fake_$(VERSION).so
	#$(INSTALL_DIR) $(1)/usr/lib/debug/usr/lib
	#$(INSTALL_DATA) $(PKG_BUILD_DIR)/lib/libplugin_fake.so.debug $(1)/usr/lib/debug/usr/lib
	$(INSTALL_DIR) $(1)/usr/share/ucollect/configs
	$(INSTALL_BIN) ./files/gen-config $(1)/usr/share/ucollect/configs/99-fake.cfg
	sed -i -e 's/VERSION/$(VERSION)/' $(1)/usr/share/ucollect/configs/99-fake.cfg
	$(INSTALL_DIR) $(1)/etc/syslog-ng.d/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/plugins/fake/firewall-syslog $(1)/etc/syslog-ng.d/ucollect-fake.conf
	$(INSTALL_DIR) $(1)/etc/firewall.d/with_reload
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/plugins/fake/firewall-init $(1)/etc/firewall.d/with_reload/99-ucollect-fake.fw
	$(INSTALL_DIR) $(1)/usr/share/ucollect/scripts
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/plugins/fake/firewall-add $(1)/usr/share/ucollect/scripts/ucollect-add-firewall
	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface
	$(INSTALL_DATA) ./files/hotplug.sh $(1)/etc/hotplug.d/iface/51-ucollect-fake
endef

$(eval $(call BuildPackage,ucollect-fake))
