#
## Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=python-libatsha204
PKG_VERSION:=4
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/libatsha204.git
PKG_ORIG_NAME:=libatsha204
PKG_SOURCE_VERSION:=3284972e0064d6d3dc0d173f436f920763ebab54
PKG_SOURCE:=$(PKG_ORIG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_ORIG_NAME)
PKG_MAINTAINER:=Stepan Henek <stepan.henek@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_ORIG_NAME)
PKG_BUILD_DEPENDS:=python

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+python +libatsha204
endef

define Build/Compile
	$(call Build/Compile/PyMod,./src/python/, install --prefix="/usr" --root="$(PKG_INSTALL_DIR)")
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* \
		$(1)$(PYTHON_PKG_DIR)
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
