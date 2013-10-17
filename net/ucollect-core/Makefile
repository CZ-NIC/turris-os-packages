#
# Copyright (C) 2013 CZ.NIC z.s.p.o. <martin.strbacka@nic.cz>
# Copyright (C) 2013 CZ.NIC z.s.p.o. <michal.vaner@nic.cz>
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#


include $(TOPDIR)/package/packages/net/ucollect-core/Makefile.common

$(eval $(call UCOLLECT_BASE,ucollect-core,19))

define Package/ucollect-core
	SECTION:=net
	CATEGORY:=Network
	DEFAULT:=y
	TITLE:=Netflow data collecting daemon
	DEPENDS:=+libpcap +librt +libopenssl +libuci +libatsha204 +socat +cznic-cacert-bundle
endef

define Package/ucollect-core/conffiles
/etc/config/ucollect
endef

define Package/ucollect-core/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/ucollect enable
/etc/init.d/ucollect restart
}
endef

define Package/ucollect-core/prerm
#!/bin/sh
/etc/init.d/ucollect disable
/etc/init.d/ucollect stop
endef

define Package/ucollect-core/install
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/ucollect $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/ucollect.init $(1)/etc/init.d/ucollect
	$(INSTALL_DIR) $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lib/libucollect_core.so $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/src/ucollect/ucollect.cfg $(1)/etc/config/ucollect
	$(INSTALL_DIR) $(1)/etc/ssl
	$(CP) $(PKG_BUILD_DIR)/src/ucollect/ucollect.pem $(1)/etc/ssl
	$(INSTALL_DIR) $(1)/usr/share/ucollect/configs
	$(CP) $(PKG_BUILD_DIR)/src/ucollect/main.cfg $(1)/usr/share/ucollect/configs/00-main.cfg
endef

$(eval $(call BuildPackage,ucollect-core))
