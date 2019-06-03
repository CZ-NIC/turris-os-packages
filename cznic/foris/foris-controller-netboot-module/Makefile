#
# Copyright (C) 2019 CZ.NIC z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-controller-netboot-module
PKG_VERSION:=0.4
PKG_RELEASE:=2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/foris-controller-netboot-module.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(BUILD_VARIANT)-$(PKG_NAME)-$(PKG_VERSION)

PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILE:=LICENSE

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk
include ../foris-controller/files/foris-controller-module.mk

PKG_UNPACK:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=\
		+foris-controller +turris-netboot-tools
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
	VARIANT:=python3
endef

define Package/$(PKG_NAME)/description
 This is a netboot module for foris-controller
endef

# Package install definition
$(eval $(call ForisControllerModule,$(PKG_NAME)))

define Package/$(1)/postinst
#!/bin/sh
set -x
[ -n "$$$${IPKG_INSTROOT}" ] || {
uci set foris-ws.main.bus=mqtt
uci set foris-controller.main.bus=mqtt
uci commit
/etc/init.d/foris-controller restart
/etc/init.d/foris-ws restart

/etc/init.d/foris-netboot-observer enable
/etc/init.d/foris-netboot-observer start
}
endef

define Package/$(1)/prerm
#!/bin/sh
set -x
/etc/init.d/foris-netboot-observer stop
/etc/init.d/foris-netboot-observer disable
endef

# redefine install
define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)$(PYTHON3_PKG_DIR)
	$(INSTALL_DIR) $(1)/usr/bin
	if [ -d $(PKG_INSTALL_DIR)/usr/bin ]; then find $(PKG_INSTALL_DIR)/usr/bin -mindepth 1 -maxdepth 1 -type f -exec $(CP) \{\} $(1)/usr/bin/ \; ; fi
	find $(PKG_INSTALL_DIR)$(PYTHON3_PKG_DIR) -mindepth 1 -maxdepth 1 \( -type f -o -type d \) -exec $(CP) \{\} $(1)$(PYTHON3_PKG_DIR)/ \;
	$(RM) $(1)/usr/lib/python*/site-packages/foris_controller_modules/__init__.py
	$(RM) $(1)/usr/lib/python*/site-packages/foris_controller_backends/__init__.py
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/foris-netboot-observer.init $(1)/usr/init.d/foris-netboot-observer.init
endef

$(eval $(call Py3Package,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_NAME)-src))
