#
# Copyright (C) 2018 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=turrishw
PKG_VERSION:=0.4.3
PKG_RELEASE:=1

PKG_LICENSE:=GPLv3

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/turrishw.git
PKG_SOURCE_VERSION:=29d8973dd645eb67e726bacc6972747c01985170
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

PKG_UNPACK:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

define Package/turrishw
	SECTION:=lang
	CATEGORY:=Languages
	SUBMENU:=Python
	TITLE:=turrishw
	DEPENDS:=+python3-light
	VARIANT:=python3
endef

define Package/turrishw/description
  turrishw is a package for providing abstraction over available interfaces on various Turris (Mox, Omnia) routers.
endef

$(eval $(call Py3Package,turrishw))
$(eval $(call BuildPackage,turrishw))
