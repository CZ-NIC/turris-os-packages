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
PKG_RELEASE:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+tvheadend
endef

define Package/$(PKG_NAME)/description
  Experimental mux definition for Czech DVB-T2
endef

define Build/Compile
	true
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/share/tvheadend/data/dvb-scan/dvb-t
	$(INSTALL_DATA) files/cz-dvb-T2 $(1)/usr/share/tvheadend/data/dvb-scan/dvb-t/cz-dvb-T2
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
set -x
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/tvheadend restart
}
endef

define Package/$(PKG_NAME)/postrm
#!/bin/sh
set -x
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/tvheadend restart
}
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
