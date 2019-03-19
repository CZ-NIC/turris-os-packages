#
# Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=ninja
PKG_VERSION:=1.9.0

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/ninja-build/ninja/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=5d7ec75828f8d3fd1a0c2f31b5b0cea780cdfe1031359228c428c1a48bfcd5b9

PKG_INSTALL:=1
HOST_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-host.mk

HOST_BUILD_DEPENDS:=python3/host

define Package/ninja
  SECTION:=devel
  CATEGORY:=Development
  TITLE:=ninja
  URL:=https://ninja-build.org/
endef

define Package/ninja/description
  Ninja is a small build system with a focus on speed.
endef

HOST_CONFIGURE_ARGS := \
	--bootstrap

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Build/Install
endef

define Build/Clean
endef

CONFIGURE_ARGS := \
	--bootstrap

define Host/Compile
	cd  $(HOST_BUILD_DIR) && $(HOST_PYTHON3_BIN) configure.py $(HOST_CONFIGURE_ARGS)
endef

define Host/Install
	$(INSTALL_DIR) $(STAGING_DIR_HOST)/usr/bin/
	$(INSTALL_BIN) $(HOST_BUILD_DIR)/ninja $(STAGING_DIR_HOST)/usr/bin/
endef

define Host/Clean
	$(call Host/Clean/Default)
	rm $(STAGING_DIR_HOST)/usr/bin/ninja
endef

$(eval $(call HostBuild,ninja))
$(eval $(call BuildPackage,ninja))
