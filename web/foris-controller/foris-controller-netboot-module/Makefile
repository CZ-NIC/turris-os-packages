#
# Copyright (C) 2019 CZ.NIC z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-controller-netboot-module
PKG_VERSION:=0.4.1
PKG_RELEASE:=6

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/foris-controller/foris-controller-netboot-module.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk
include ../foris-controller/files/foris-controller-module.mk

define Package/foris-controller-netboot-module
  SECTION:=web
  CATEGORY:=Web
  SUBMENU:=Foris Controller
  TITLE:=Foris controller netboot module
  DEPENDS:=\
    +foris-controller \
    +turris-netboot-tools
  VARIANT:=python3
endef

define Package/foris-controller-netboot-module/description
  This is a netboot module for foris-controller.
endef

define Package/foris-controller-netboot-module/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
	uci set foris-ws.main.bus=mqtt
	uci set foris-controller.main.bus=mqtt
	uci commit
	/etc/init.d/foris-controller restart
	/etc/init.d/foris-ws restart
	/etc/init.d/lighttpd restart

	/etc/init.d/foris-netboot-observer enable
	/etc/init.d/foris-netboot-observer start
}
endef

define Package/foris-controller-netboot-module/prerm
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
	/etc/init.d/foris-netboot-observer stop
	/etc/init.d/foris-netboot-observer disable
}
endef

define ForisControllerModule/foris-controller-netboot-module/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/foris-netboot-observer.init $(1)/etc/init.d/foris-netboot-observer
endef

$(eval $(call ForisControllerModule,foris-controller-netboot-module))
# call BuildPackage <= assures OWR build system that this is package
