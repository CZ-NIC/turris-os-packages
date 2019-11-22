#
## Copyright (C) 2016-2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=rainbow-omnia
PKG_VERSION:=3.1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/rainbow_omnia.git
PKG_SOURCE_VERSION:=d4ded015bd5a400059ea20f2234a311e749dc519
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/rainbow-omnia
  TITLE:=rainbow-omnia
  URL:=https://gitlab.labs.nic.cz/turris/rainbow_omnia
  PROVIDES:=turris-rainbow
  DEPENDS+=@TARGET_mvebu_cortexa9_DEVICE_cznic_turris-omnia
endef

define Package/rainbow-omnia/conffiles
/etc/config/rainbow
endef

define Build/Compile
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS)
endef

define Package/rainbow-omnia/install
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/rainbow $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/rainbow.init $(1)/etc/init.d/rainbow
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_DATA) ./files/rainbow.config $(1)/etc/config/rainbow
	$(INSTALL_DIR) $(1)/etc/cron.d
	$(INSTALL_DATA) ./files/rainbow.cron $(1)/etc/cron.d/rainbow
	$(INSTALL_BIN) ./files/rainbow_button_sync.sh $(1)/usr/bin/rainbow_button_sync.sh
endef

define Package/rainbow-omnia/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
    /etc/init.d/rainbow enable
    /etc/init.d/rainbow restart
}
endef

define Package/rainbow-omnia/prerm
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
    /etc/init.d/rainbow stop
    /etc/init.d/rainbow disable
    rainbow all auto white
}
endef

$(eval $(call BuildPackage,rainbow-omnia))
