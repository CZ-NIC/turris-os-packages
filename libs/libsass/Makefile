#
## Copyright (C) 2018-2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=libsass
PKG_VERSION:=3.6.4
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/sass/libsass/tar.gz/$(PKG_VERSION)?
PKG_HASH:=f9484d9a6df60576e791566eab2f757a97fd414fce01dd41fc0a693ea5db2889

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

HOST_BUILD_DEPENDS:=
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk

define Package/libsass
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=libsass
  URL:=https://sass-lang.com/libsass
  DEPENDS:=libstdcpp
endef

define Package/libsass/description
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

define Package/libsass/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/lib/libsass.so $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libsass))
$(eval $(call HostBuild))
