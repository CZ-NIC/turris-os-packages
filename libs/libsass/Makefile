#
## Copyright (C) 2018 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=libsass
PKG_VERSION:=3.5.4
PKG_RELEASE:=1
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/sass/libsass.git
PKG_SOURCE_VERSION:=3.5.4
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

HOST_BUILD_DEPENDS:=

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk


define Package/$(PKG_NAME)
	TITLE:=libsass
	DEPENDS:=libstdcpp
endef

define Package/$(PKG_NAME)/description
	LibSass is a C++ port of the original Ruby Sass CSS compiler with a C API.
endef

MAKE_FLAGS += \
	BUILD=shared \
	PREFIX=/ \

define Host/Compile
	cd $(HOST_BUILD_DIR)/; $(MAKE) -C "$(HOST_BUILD_DIR)" BUILD=shared PREFIX=$(STAGING_DIR_HOST)/usr/lib/
endef

define Host/Install
	cd $(HOST_BUILD_DIR)/; $(MAKE) -C "$(HOST_BUILD_DIR)" BUILD=shared PREFIX=$(STAGING_DIR_HOST)/usr/lib/ install
endef

define Build/Compile
	$(call Build/Compile/Default)
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/lib/libsass.so $(1)/usr/lib/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
$(eval $(call HostBuild))
