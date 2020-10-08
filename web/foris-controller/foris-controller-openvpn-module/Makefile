#
# Copyright (C) 2019 CZ.NIC z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-controller-openvpn-module
PKG_VERSION:=0.6.2
PKG_RELEASE:=3

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/foris-controller/foris-controller-openvpn-module.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk
include ../foris-controller/files/foris-controller-module.mk

define Package/foris-controller-openvpn-module
  SECTION:=web
  CATEGORY:=Web
  SUBMENU:=Foris Controller
  TITLE:=Foris controller OpenVPN module
  DEPENDS:=\
    +foris-controller \
    +turris-cagen \
    +openvpn-openssl \
    +dhparam
  VARIANT:=python3
endef

define Package/foris-controller-openvpn-module/description
  This is a OpenVPN module for foris-controller.
endef

define Package/foris-controller-openvpn-module/postinst
#!/bin/sh
if [ -z "$$IPKG_INSTROOT" ]; then
	if uci -q get openvpn.server_turris.comp_lzo > /dev/null ; then
		uci del openvpn.server_turris.comp_lzo
		if ! uci -q get openvpn.server_turris.compress > /dev/null ; then
			uci set openvpn.server_turris.compress=lzo
		fi
		uci commit openvpn
	fi

	/etc/init.d/foris-controller restart
fi
endef

$(eval $(call ForisControllerModule,foris-controller-openvpn-module))
# call BuildPackage <= assures OWR build system that this is package
