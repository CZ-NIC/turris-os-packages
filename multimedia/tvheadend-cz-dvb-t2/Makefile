#
## Copyright (C) 2018 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=tvheadend-cz-dvt-t2
PKG_VERSION:=1
PKG_RELEASE:=$(AUTORELEASE)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/tvheadend-cz-dvt-t2
	TITLE:=Czech DVB-T2 mux for Tvheadend
	DEPENDS:=+tvheadend
endef

define Package/tvheadend-cz-dvt-t2/description
  Experimental mux definition for Czech DVB-T2
endef

Build/Compile:=:

define Package/tvheadend-cz-dvt-t2/install
	$(INSTALL_DIR) $(1)/usr/share/tvheadend/data/dvb-scan/dvb-t
	$(INSTALL_DATA) files/cz-dvb-T2 $(1)/usr/share/tvheadend/data/dvb-scan/dvb-t/cz-dvb-T2
endef

define Package/tvheadend-cz-dvt-t2/postinst
#!/bin/sh
set -x
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/tvheadend restart
}
endef

define Package/tvheadend-cz-dvt-t2/postrm
#!/bin/sh
set -x
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/tvheadend restart
}
endef

$(eval $(call BuildPackage,tvheadend-cz-dvt-t2))
