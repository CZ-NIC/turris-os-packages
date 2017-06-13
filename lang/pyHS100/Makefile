#
# Copyright (C) 2017 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pyHS100
PKG_VERSION:=0.2.4.2
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/GadgetReactor/pyHS100.git
PKG_SOURCE_VERSION:=$(PKG_VERSION)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)


PKG_BUILD_DEPENDS:=python

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/pyHS100
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	TITLE:=pyHS100
	URL:=https://github.com/GadgetReactor/pyHS100
	DEPENDS:=+python +click +click-datetime +python-future
endef

define Package/pyHS100/description
 A cli tool for controlling TP-Link smart home plugs.
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix="/usr" --root="$(PKG_INSTALL_DIR)")
endef

define PyPackage/pyHS100/install
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) ./files/pyhs100 $(1)/usr/bin/pyhs100
endef

$(eval $(call PyPackage,pyHS100))
$(eval $(call BuildPackage,pyHS100))
