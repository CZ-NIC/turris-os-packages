#
# Copyright (C) 2017 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#



include $(TOPDIR)/rules.mk

PKG_NAME:=click
PKG_VERSION:=e634d7f78b906294fd21fb8b166fa4a71746b76b
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/pallets/click.git
PKG_SOURCE_VERSION:=$(PKG_VERSION)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)


PKG_BUILD_DEPENDS:=python

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/click
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	TITLE:=click
	URL:=https://github.com/pallets/click
	DEPENDS:=+python
endef


define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix="/usr" --root="$(PKG_INSTALL_DIR)")
endef

$(eval $(call PyPackage,click))
$(eval $(call BuildPackage,click))
