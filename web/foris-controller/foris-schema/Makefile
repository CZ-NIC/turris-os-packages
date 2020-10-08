#
# Copyright (C) 2018 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-schema
PKG_VERSION:=0.7.1
PKG_RELEASE:=3

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/foris-controller/foris-schema.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=COPYING

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/foris-schema
  SECTION:=web
  CATEGORY:=Web
  SUBMENU:=Foris Controller
  TITLE:=Foris schema
  URL:=https://gitlab.nic.cz/turris/foris-controller/foris-schema
  DEPENDS:=+python3-jsonschema
  VARIANT:=python3
endef

define Package/foris-schema/description
	Library which validates whether the json matches
	the protocol use between Foris web and a configuration backend.
endef

$(eval $(call Py3Package,foris-schema))
$(eval $(call BuildPackage,foris-schema))
$(eval $(call BuildPackage,foris-schema-src))
