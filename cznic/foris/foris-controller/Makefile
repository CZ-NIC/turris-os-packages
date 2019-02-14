#
# Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-controller
PKG_VERSION:=0.11.7
PKG_RELEASE:=1
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/foris-controller
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
PKG_LICENSE:=GPL-3.0

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

define Package/foris-controller
	TITLE:=foris-controller
	URL:=https://gitlab.labs.nic.cz/turris/foris-controller
	DEPENDS:=+foris-controller-app +foris-controller-hotplug
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef

define Package/foris-controller-app
	TITLE:=foris-controller-app
	URL:=https://gitlab.labs.nic.cz/turris/foris-controller
	DEPENDS:=\
		+python3-light +python3-ubus +python3-prctl +python3-multiprocessing +python3-pbkdf2 \
		+foris-schema-python3 +python3-setuptools +python3-turrishw \
		+server-uplink +turris-maintain +updater-ng-supervisor +user-notify \
		+l10n_supported +sqm-scripts +fosquitto +python3-paho-mqtt +turris-cagen \
		+crypto-wrapper
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef

define Package/foris-controller/description
	An program which is placed in top of a message bus and translates requests to commands for backends.
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,,install --prefix=/usr --root=$(PKG_INSTALL_DIR))
endef

define Package/foris-controller-app/conffiles
/etc/config/foris-controller
endef

define Package/foris-controller-app/install
	$(INSTALL_DIR) $(1)
	$(CP) $(PKG_INSTALL_DIR)/* $(1)/
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF) ./files/foris-controller.conf $(1)/etc/config/foris-controller
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/foris-controller.init $(1)/etc/init.d/foris-controller
endef

define Package/foris-controller/install
	true  # This is required otherwise the package won't be created
endef

define Package/foris-controller-hotplug
	TITLE:=foris-controller-hotplug
	URL:=https://gitlab.labs.nic.cz/turris/foris-controller
	DEPENDS:=\
		+foris-controller-app +foris-client-bin +netifd
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef

define Package/foris-controller-hotplug/install
	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface/
	$(INSTALL_BIN) ./files/foris-controller.hotplug $(1)/etc/hotplug.d/iface/99-foris-controller
endef

define Package/foris-controller-app/postinst
#!/bin/sh
set -x
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/foris-controller enable
/etc/init.d/foris-controller restart
}
endef

define Package/foris-controller-app/prerm
#!/bin/sh
set -x
/etc/init.d/foris-controller stop
/etc/init.d/foris-controller disable
endef

$(eval $(call BuildPackage,foris-controller-hotplug))
$(eval $(call BuildPackage,foris-controller-app))
$(eval $(call BuildPackage,foris-controller))
