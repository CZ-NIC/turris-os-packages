#
# Copyright (C) 2013-2014 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#


include $(TOPDIR)/package/packages/net/ucollect-prog/Makefile.common

$(eval $(call UCOLLECT_BASE,ucollect-prog,91))

BASE_LIB_DEPS:=+libpcap +librt +libopenssl +libuci +libatsha204 +socat +zlib

define Package/ucollect-lib
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Netflow data collecting daemon
	DEPENDS:=$(BASE_LIB_DEPS)
endef

define Package/ucollect-prog
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Netflow data collecting daemon
	DEPENDS:=+ucollect-lib +ucollect-config +cznic-cacert-bundle $(BASE_LIB_DEPS)
endef

define Package/lcollect
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Netflow data collecting daemon
	DEPENDS:=+ucollect-lib $(BASE_LIB_DEPS)
endef

define Package/lcollect/conffiles
/etc/config/lcollect
endef

define Package/ucollect-config
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Configuration for ucollect
endef

define Package/ucollect-config/conffiles
/etc/config/ucollect
endef

define Package/ucollect-prog/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/ucollect enable
/etc/init.d/ucollect restart
}
endef

define Package/ucollect-prog/prerm
#!/bin/sh
/etc/init.d/ucollect disable
/etc/init.d/ucollect stop
endef

define Package/ucollect-prog/install
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/ucollect $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/ucollect.init $(1)/etc/init.d/ucollect
	$(INSTALL_DIR) $(1)/usr/share/ucollect/configs
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/src/ucollect/main.cfg $(1)/usr/share/ucollect/configs/00-main.cfg
	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface/
	$(INSTALL_DATA) ./files/ucollect.hotplug $(1)/etc/hotplug.d/iface/50-ucollect
endef

ifeq ($(CONFIG_TARGET_mpc85xx_p2020_nand_TURRISNAND),y)
define Package/ucollect-config/install
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/src/ucollect/ucollect-turris.cfg $(1)/etc/config/ucollect
endef
else
define Package/ucollect-config/install
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/src/ucollect/ucollect.cfg $(1)/etc/config/ucollect
endef
endif

define Package/ucollect-lib/install
	$(INSTALL_DIR) $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lib/libucollect_core.so $(1)/usr/lib/
endef

define Package/lcollect/install
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/lcollect.init $(1)/etc/init.d/lcollect
	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface/
	$(INSTALL_DATA) ./files/lcollect.hotplug $(1)/etc/hotplug.d/iface/50-lcollect
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/src/lcollect/lcollect-turris.cfg $(1)/etc/config/lcollect
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/lcollect $(1)/usr/bin/
endef

define Package/lcollect/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/lcollect enable
/etc/init.d/lcollect restart
}
endef

define Package/lcollect/prerm
#!/bin/sh
/etc/init.d/lcollect disable
/etc/init.d/lcollect stop
endef

$(eval $(call BuildPackage,ucollect-lib))
$(eval $(call BuildPackage,ucollect-prog))
$(eval $(call BuildPackage,ucollect-config))
$(eval $(call BuildPackage,lcollect))
