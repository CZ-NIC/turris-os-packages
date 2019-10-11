#
## Copyright (C) 2019 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=ltemetr-core
PKG_VERSION:=0.3
PKG_RELEASE:=1

PKG_SOURCE:=core-v$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/ltemetr/core/-/archive/v$(PKG_VERSION)/
PKG_HASH:=0cf4207a77c2ec9a7ccfbfb176756a6d93e8720dde8b4a6471809ac255cf764c

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_DIR:=$(BUILD_DIR)/core-v$(PKG_VERSION)

PKG_BUILD_DEPENDS:=python3 python3-setuptools

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

define Package/$(PKG_NAME)
  TITLE:=LTE benchmark and speed measurement application
  URL:=https://gitlab.labs.nic.cz/turris/ltemetr/core
  DEPENDS:=+netmetr +coreutils-date
  VARIANT:=python3
endef

define Package/$(PKG_NAME)/description
  Application for download speed measurement
  which provides additional info about LTE and
  GPS parametres.
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,,install --prefix=/usr --root=$(PKG_INSTALL_DIR))
endef

define Py3Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)
	$(CP) $(PKG_INSTALL_DIR)/* $(1)/

	$(INSTALL_DIR)  $(1)/etc/config
	$(INSTALL_CONF)	./files/ltemetr.config $(1)/etc/config/ltemetr

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/ltemetr.init $(1)/etc/init.d/ltemetr
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	/etc/init.d/ltemetr enable
	/etc/init.d/ltemetr start
}
endef

define Package/$(PKG_NAME)/prerm
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	/etc/init.d/ltemetr disable
	/etc/init.d/ltemetr stop
}
endef

define Package/$(PKG_NAME)/conffiles
/etc/config/ltemetr
endef

$(eval $(call Py3Package,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_NAME)))
