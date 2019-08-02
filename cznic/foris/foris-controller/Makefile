#
# Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-controller
PKG_VERSION:=1.0.3
PKG_RELEASE:=1
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/foris-controller
PKG_SOURCE_VERSION:=838345eca210b0904f4ce2958dc6ad06709707e4
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(BUILD_VARIANT)-$(PKG_NAME)-$(PKG_VERSION)
PKG_LICENSE:=GPL-3.0

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

PKG_UNPACK:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

define Package/foris-controller
	TITLE:=foris-controller
	URL:=https://gitlab.labs.nic.cz/turris/foris-controller
	DEPENDS:=+foris-controller-app +foris-controller-hotplug
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef

# This is required otherwise the package won't be created
Package/foris-controller/install:=:

define Package/foris-controller-app
	TITLE:=foris-controller-app
	URL:=https://gitlab.labs.nic.cz/turris/foris-controller
	DEPENDS:=\
		+python3-light +python3-ubus +python3-prctl +python3-multiprocessing +python3-pbkdf2 \
		+foris-schema +python3-setuptools +turrishw \
		+turris-maintain +updater-supervisor +user-notify \
		+l10n_supported +sqm-scripts +fosquitto +python3-paho-mqtt +turris-cagen \
		+crypto-wrapper
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
	VARIANT:=python3
endef

define Package/foris-controller/description
	An program which is placed in top of a message bus and translates requests to commands for backends.
endef

define Package/foris-controller-app/conffiles
/etc/config/foris-controller
endef

define Py3Package/foris-controller-app/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF) ./files/foris-controller.conf $(1)/etc/config/foris-controller
ifeq ($(CONFIG_TARGET_mvebu_cortexa53_DEVICE_cznic-mox),y)
	sed -i 's|#\(option single true\)|\1|' $(1)/etc/config/foris-controller
endif
	$(INSTALL_CONF) ./files/foris-controller-subordinates.conf $(1)/etc/config/foris-controller-subordinates
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/foris-controller.init $(1)/etc/init.d/foris-controller
endef

define Package/foris-controller-hotplug
	TITLE:=foris-controller-hotplug
	URL:=https://gitlab.labs.nic.cz/turris/foris-controller
	DEPENDS:=\
		+foris-controller-app +foris-client +netifd
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
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
