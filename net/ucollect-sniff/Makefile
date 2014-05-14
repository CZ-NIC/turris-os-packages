#
## Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#

include $(TOPDIR)/package/packages/net/ucollect-core/Makefile.common

VERSION:=2

$(eval $(call UCOLLECT_PLUGIN,sniff,$(VERSION)))

define Package/ucollect-sniff/install
	$(INSTALL_DIR) $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lib/libplugin_sniff.so $(1)/usr/lib/libplugin_ucollect_sniff_$(VERSION).so
	$(INSTALL_DIR) $(1)/usr/share/ucollect/configs
	echo 'config plugin' >$(1)/usr/share/ucollect/configs/99-sniff.cfg
	echo "	option libname 'libplugin_ucollect_sniff_$(VERSION).so'" >>$(1)/usr/share/ucollect/configs/99-sniff.cfg
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/plugins/sniff/sniff-ping $(1)/usr/bin/ucollect-sniff-ping
endef

$(eval $(call BuildPackage,ucollect-sniff))
