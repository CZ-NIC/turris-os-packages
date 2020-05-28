#
## Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=libb64
PKG_VERSION:=1.2.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).zip
PKG_SOURCE_URL:=https://sourceforge.net/projects/libb64/files
PKG_HASH:=20106f0ba95cfd9c35a13c71206643e3fb3e46512df3e2efb2fdbf87116314b2

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/host-build.mk
include $(INCLUDE_DIR)/package.mk

EXTRA_CFLAGS += -fPIC

define Build/Compile
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR)/src $(MAKE_FLAGS)
endef

define Host/Compile
	$(MAKE) $(HOST_JOBS) -C $(HOST_BUILD_DIR)/src $(HOST_MAKE_FLAGS)
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/src/libb64.a $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/include/b64
	$(CP) $(PKG_BUILD_DIR)/include/b64/* $(1)/usr/include/b64/
endef

define Host/Install
	$(INSTALL_DIR) $(STAGING_DIR_HOST)/usr/lib
	$(CP) $(HOST_BUILD_DIR)/src/libb64.a $(STAGING_DIR_HOST)/usr/lib/
	$(INSTALL_DIR) $(STAGING_DIR_HOST)/usr/include/b64
	$(CP) $(HOST_BUILD_DIR)/include/b64/* $(STAGING_DIR_HOST)/usr/include/b64/
endef

$(eval $(call HostBuild))
$(eval $(call Build/DefaultTargets))
