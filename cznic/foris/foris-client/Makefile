#
# Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-client
PKG_VERSION:=0.9.7
PKG_RELEASE:=1
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/foris-client
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(BUILD_VARIANT)-$(PKG_NAME)-$(PKG_VERSION)
PKG_LICENSE:=GPL-3.0

PKG_BUILD_DEPENDS:=python3 python3-setuptools

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

PKG_UNPACK:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

define Package/foris-client
	URL:=https://gitlab.labs.nic.cz/turris/foris-client
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
	TITLE:=foris-client
	DEPENDS:= \
		+foris-controller-app \
		+python3-light \
		+python3-ubus \
		+python3-setuptools
	VARIANT:=python3
endef

define Package/foris-client/description
	An program/library which is act as a client of foris-controller.
endef

define Package/foris-client/install
	$(INSTALL_DIR) $(1)
	$(CP) $(PKG_INSTALL_DIR)/* $(1)/
	$(INSTALL_BIN) ./files/foris-client-wrapper $(1)/usr/bin/foris-client-wrapper
	$(INSTALL_BIN) ./files/foris-notify-wrapper $(1)/usr/bin/foris-notify-wrapper
endef

$(eval $(call Py3Package,foris-client))
$(eval $(call BuildPackage,foris-client))
$(eval $(call BuildPackage,foris-client-src))
