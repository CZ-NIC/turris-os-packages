#
## Copyright (C) 2014 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#

include $(TOPDIR)/package/packages/net/ucollect-core/Makefile.common

$(eval $(call UCOLLECT_BASE,lcollect-majordomo,1))

define Package/lcollect-majordomo
	SECTION:=net
	CATEGORY:=Network
	TITLE:=The majordomo plugin for lcollect
	DEPENDS:=+lcollect
endef

define Package/lcollect-majordomo/install
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/src/plugins/majordomo/scripts/majordomo.conf $(1)/etc/config/majordomo
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/plugins/majordomo/scripts/majordomo_db.sh $(1)/usr/bin/majordomo_db.sh
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/plugins/majordomo/scripts/majordomo_merge.lua $(1)/usr/bin/majordomo_merge.lua
	$(INSTALL_DIR) $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lib/libplugin_majordomo.so $(1)/usr/lib/libplugin_lcollect_majordomo_$(PKG_VERSION).so
	$(INSTALL_DIR) $(1)/usr/share/lcollect/configs
	echo 'config plugin' >$(1)/usr/share/lcollect/configs/99-lcollect-majordomo.cfg
	echo "	option libname 'libplugin_lcollect_majordomo_$(PKG_VERSION).so'" >>$(1)/usr/share/lcollect/configs/99-lcollect-majordomo.cfg
endef

# TODO: Postinst and postrm scripts to reload lcollect, once it has init script

$(eval $(call BuildPackage,lcollect-majordomo))
