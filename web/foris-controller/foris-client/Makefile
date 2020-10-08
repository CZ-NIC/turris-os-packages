#
# Copyright (C) 2019 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-client
PKG_VERSION:=1.0.3
PKG_RELEASE:=3

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/foris-controller/foris-client.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/foris-client
  SECTION:=web
  CATEGORY:=Web
  SUBMENU:=Foris Controller
  TITLE:=foris-client
  URL:=https://gitlab.nic.cz/turris/foris-controller/foris-client
  DEPENDS:= \
    +foris-controller-app \
    +python3-light \
    +python3-ubus \
    +python3-setuptools \
    +crypto-wrapper
  VARIANT:=python3
endef

define Package/foris-client/description
  An program/library which is act as a client of foris-controller.
endef

define Py3Package/foris-client/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin/

	$(INSTALL_BIN) ./files/foris-client-wrapper $(1)/usr/bin/foris-client-wrapper
	$(INSTALL_BIN) ./files/foris-notify-wrapper $(1)/usr/bin/foris-notify-wrapper
endef

$(eval $(call Py3Package,foris-client))
$(eval $(call BuildPackage,foris-client))
$(eval $(call BuildPackage,foris-client-src))
