#
## Copyright (C) 2016-2017 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=netmetr
PKG_VERSION:=1.2.1
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/misc.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=b5accc608c9b57194486282dac4b5380b097b7f4
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=Speed measurement application
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
	DEPENDS:=+rmbt-client +vixie-cron +python-light
endef
define Package/$(PKG_NAME)/description
  Python wrapper for RMBT C application that
  provides download and upload
  speed measurements.
endef

define Build/Compile
  true
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) 	$(1)/usr/bin
	$(INSTALL_BIN) 	$(PKG_BUILD_DIR)/netmetr/netmetr $(1)/usr/bin/netmetr

	$(INSTALL_DIR)  $(1)/etc/config
	$(INSTALL_CONF)	./files/netmetr.config		$(1)/etc/config/netmetr

	$(INSTALL_DIR)  $(1)/etc/cron.d
	$(INSTALL_DATA) ./files/netmetr.cron 		$(1)/etc/cron.d/netmetr
endef

define Package/$(PKG_NAME)/conffiles
/etc/config/netmetr
endef

define Package/$(PKG_NAME)/preinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
[ \! -f /etc/config/netmetr ] || cp /etc/config/netmetr /tmp
}
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
[ \! -f /tmp/netmetr ] || cp /tmp/netmetr /etc/config
}
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
