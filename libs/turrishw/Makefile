#
# Copyright (C) 2018-2022 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=turrishw
PKG_VERSION:=0.8.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/turrishw.git
PKG_MIRROR_HASH:=4d928ed9636fbe5719cfb4008333978c5c410ff559db851102b4e5cc6e2326c9
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=BSL-1.0
PKG_LICENSE_FILES:=LICENSE_1_0.txt

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/turrishw
  SECTION:=lang
  CATEGORY:=Languages
  SUBMENU:=Python
  TITLE:=turrishw
  DEPENDS:=+python3-light +python3-logging
  VARIANT:=python3
endef

define Package/turrishw/description
  turrishw is a package for providing abstraction over available interfaces on various Turris (Mox, Omnia) routers.
endef

$(eval $(call Py3Package,turrishw))
$(eval $(call BuildPackage,turrishw))
$(eval $(call BuildPackage,turrishw-src))
