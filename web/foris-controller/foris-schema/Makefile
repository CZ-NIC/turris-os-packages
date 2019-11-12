#
# Copyright (C) 2018 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-schema
PKG_VERSION:=0.7.1
PKG_RELEASE:=1
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/foris-controller/foris-schema
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(BUILD_VARIANT)-$(PKG_NAME)-$(PKG_VERSION)
PKG_LICENSE:=GPL-3.0

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

PKG_UNPACK:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

define Package/foris-schema
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
	URL:=https://gitlab.labs.nic.cz/turris/foris-controller/foris-schema
	TITLE:=foris-schema
	DEPENDS:=+python3-jsonschema
	VARIANT=python3
endef

define Package/foris-schema/description
	Library which validates whether the json matches
	the protocol use between Foris web and a configuration backend.
endef

$(eval $(call Py3Package,foris-schema))
$(eval $(call BuildPackage,foris-schema))
$(eval $(call BuildPackage,foris-schema-src))
