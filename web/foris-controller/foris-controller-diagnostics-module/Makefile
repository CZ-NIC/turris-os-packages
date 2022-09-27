#
# Copyright (C) 2019-2020 CZ.NIC z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-controller-diagnostics-module
PKG_VERSION:=1.0.5
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/foris-controller/foris-controller-diagnostics-module.git
PKG_MIRROR_HASH:=e6f57a304b7a4aa394d3fe963f74d5553a010296a708b36712de76a0726d1f7a
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk
include ../foris-controller/files/foris-controller-module.mk

define Package/foris-controller-diagnostics-module
  SECTION:=web
  CATEGORY:=Web
  SUBMENU:=Foris Controller
  TITLE:=Foris controller Diagnostics module
  DEPENDS:= \
    +foris-controller \
    +turris-diagnostics
endef

define Package/foris-controller-diagnostics-module/description
  This is a diagnostics module for foris-controller.
endef

$(eval $(call ForisControllerModule,foris-controller-diagnostics-module))
# call BuildPackage <= assures OWR build system that this is package
