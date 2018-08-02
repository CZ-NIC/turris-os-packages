#
# Copyright (C) 2013-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#


include ../ucollect-prog/Makefile.common

$(eval $(call UCOLLECT_BASE,ucollect-prog,124))

define Package/ucollect-lib
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Netflow data collecting daemon base library
	DEPENDS:=+libpcap +librt +libopenssl +libuci +libatsha204 +socat +zlib +gdb
endef

define Package/ucollect-prog
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Netflow data collecting daemon
	DEPENDS:=+ucollect-lib +ucollect-config +cznic-cacert-bundle +libpcap +librt +libopenssl +libuci +libatsha204 +socat +zlib +gdb
endef

define Package/lcollect
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Netflow data collecting daemon
	DEPENDS:=+ucollect-lib +libpcap +librt +libopenssl +libuci +libatsha204 +socat +zlib +gdb
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
/etc/init.d/ucollect disable
rm -f /etc/rc.d/S50ucollect
/etc/init.d/ucollect enable
/etc/init.d/ucollect restart
}
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
	#$(INSTALL_DIR) $(1)/usr/lib/debug/usr/bin
	#$(INSTALL_DATA) $(PKG_BUILD_DIR)/bin/ucollect.debug $(1)/usr/lib/debug/usr/bin/
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
	#$(INSTALL_DIR) $(1)/usr/lib/debug/usr/lib
	#$(INSTALL_DATA) $(PKG_BUILD_DIR)/lib/libucollect_core.so.debug $(1)/usr/lib/debug/usr/lib
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
	#$(INSTALL_DIR) $(1)/usr/lib/debug/usr/bin
	#$(INSTALL_DATA) $(PKG_BUILD_DIR)/bin/lcollect.debug $(1)/usr/lib/debug/usr/bin/
endef


define Package/ucollect-config/postrm
#!/bin/sh
[ -f "$$IPKG_INSTROOT/etc/config/ucollect" ] || touch "$$IPKG_INSTROOT/etc/config/ucollect" || true
endef

define Package/ucollect-config/preinst
#!/bin/sh
[ -n "`cat "$$IPKG_INSTROOT/etc/config/ucollect" 2 >/dev/null`" ] || rm -f "$$IPKG_INSTROOT/etc/config/ucollect"
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
