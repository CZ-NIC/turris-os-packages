#
## Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=python-libatsha204
PKG_VERSION:=3
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=ssh://git@git.nic.cz/router/libatsha204
PKG_ORIG_NAME:=libatsha204
PKG_SOURCE_VERSION:=3284972e0064d6d3dc0d173f436f920763ebab54
PKG_SOURCE:=$(PKG_ORIG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_ORIG_NAME)
PKG_MAINTAINER:=Stepan Henek <stepan.henek@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_ORIG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+python +libatsha204
endef

define Build/Compile
	cd $(PKG_BUILD_DIR)/src/python; $(CONFIGURE_VARS) python ./setup.py install --prefix="$(PKG_INSTALL_DIR)/usr"
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)
	$(CP) $(PKG_INSTALL_DIR)/* $(1)/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
