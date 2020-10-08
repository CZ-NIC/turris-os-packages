#
# Copyright (C) 2019-2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-controller
PKG_VERSION:=1.0.19
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/foris-controller/foris-controller.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/foris-controller
  SECTION:=web
  CATEGORY:=Web
  SUBMENU:=Foris Controller
  TITLE:=foris-controller
  URL:=https://gitlab.nic.cz/turris/foris-controller/foris-controller
  DEPENDS:=+foris-controller-app +foris-controller-hotplug
endef

# This is required otherwise the package won't be created
Package/foris-controller/install:=:

define Package/foris-controller-app
  TITLE:=foris-controller-app
  URL:=https://gitlab.nic.cz/turris/foris-controller/foris-controller
  DEPENDS:=\
    +python3-light +python3-ubus +python3-prctl +python3-multiprocessing +python3-pbkdf2 \
    +foris-schema +python3-setuptools +turrishw \
    +turris-maintain +updater-supervisor +user-notify \
    +l10n-supported +sqm-scripts +fosquitto +python3-paho-mqtt +turris-cagen \
   +crypto-wrapper +python3-slugify
  VARIANT:=python3
endef

define Package/foris-controller/description
  An program which is placed in top of a message bus and translates requests to commands for backends.
endef

define Package/foris-controller-app/conffiles
/etc/config/foris-controller
/etc/config/foris
endef

define Py3Package/foris-controller-app/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF) ./files/foris-controller.conf $(1)/etc/config/foris-controller
	touch $(1)/etc/config/foris
ifeq ($(CONFIG_TARGET_mvebu_cortexa53_DEVICE_cznic-mox),y)
	sed -i 's|#\(option single true\)|\1|' $(1)/etc/config/foris-controller
endif
	$(INSTALL_CONF) ./files/foris-controller-subordinates.conf $(1)/etc/config/foris-controller-subordinates
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/foris-controller.init $(1)/etc/init.d/foris-controller
endef

define Package/foris-controller-hotplug
  TITLE:=foris-controller-hotplug
  URL:=https://gitlab.nic.cz/turris/foris-controller/foris-controller
  DEPENDS:= \
    +foris-controller-app \
    +foris-client \
    +netifd
endef

define Package/foris-controller-hotplug/install
	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface/
	$(INSTALL_BIN) ./files/foris-controller.hotplug $(1)/etc/hotplug.d/iface/99-foris-controller
endef

define Package/foris-controller-app/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	/etc/init.d/foris-controller enable
	/etc/init.d/foris-controller restart
}
endef

define Package/foris-controller-app/prerm
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	/etc/init.d/foris-controller stop
	/etc/init.d/foris-controller disable
}
endef

$(eval $(call Py3Package,foris-controller-app))
$(eval $(call BuildPackage,foris-controller))
$(eval $(call BuildPackage,foris-controller-hotplug))
$(eval $(call BuildPackage,foris-controller-app))
