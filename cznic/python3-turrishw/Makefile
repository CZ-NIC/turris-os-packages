#
# Copyright (C) 2018 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python3-turrishw
PKG_VERSION:=0
PKG_RELEASE:=1
PKG_LICENSE:=GPLv3

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/turrishw.git
PKG_SOURCE_VERSION:=3684bf7a8d19cd4eeb7066062bc2fe807fecde8f
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

PKG_UNPACK:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

define Package/python3-turrishw
	SECTION:=lang
	CATEGORY:=Languages
	SUBMENU:=Python
	TITLE:=python3-turrishw
	DEPENDS:=+python3
	VARIANT:=python3
endef

define Package/python3-turrishw/description
turrishw is a package for providing abstraction over available interfaces on various Turris (Mox, Omnia) routers
endef

define PyPackage/python3-turrishw/filespec
+|$(PYTHON_PKG_DIR)
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,,install --prefix="/usr" --root="$(PKG_INSTALL_DIR)")
endef

$(eval $(call Py3Package,python3-turrishw))
$(eval $(call BuildPackage,python3-turrishw))
