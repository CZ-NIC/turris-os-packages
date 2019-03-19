#
# Copyright (C) 2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=meson
PKG_VERSION:=0.49.2
PKG_RELEASE:=1

PKG_SOURCE:=meson-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/mesonbuild/meson/releases/download/$(PKG_VERSION)/
PKG_HASH:=ef9f14326ec1e30d3ba1a26df0f92826ede5a79255ad723af78a2691c37109fd

HOST_BUILD_DEPENDS:=python3 python3/host
PKG_BUILD_DEPENDS:=python3/host python3/host

PKG_BUILD_DIR:=$(BUILD_DIR)/meson-$(PKG_VERSION)
HOST_BUILD_DIR:=$(BUILD_DIR)/meson-$(PKG_VERSION)

include $(INCLUDE_DIR)/host-build.mk
include $(INCLUDE_DIR)/package.mk


define Package/meson
  SECTION:=devel
  CATEGORY:=Development
  TITLE:=Meta build system
  URL:=https://mesonbuild.com/
  DEPENDS:=+python3
  MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef

define Package/meson/description
  Easily download, build, install, upgrade, and uninstall Python packages
endef

define Build/Compile
	$(call  Host/Compile)
endef

define Build/InstallDev
	$(call Host/Install)
endef

define Package/meson/install
	$(call Host/Install)
endef

CROSS_CONF=$(STAGING_DIR)/cross_conf.txt

define Host/Compile
	echo [binaries] >$(CROSS_CONF)
	echo c = \'$(TARGET_CC_NOCACHE)\' >>$(CROSS_CONF)
	echo cpp = \'$(TARGET_CXX_NOCACHE)\'>>$(CROSS_CONF)
	echo ar = \'$(TARGET_AR)\'>>$(CROSS_CONF)
	echo strip = \'$(TOOLCHAIN_DIR)/$(REAL_GNU_TARGET_NAME)/bin/strip\'>>$(CROSS_CONF)
	echo pkgconfig = \'$(PKG_CONFIG).real\'>>$(CROSS_CONF)
	echo [host_machine]>>$(CROSS_CONF)
	echo system = \'linux\'>>$(CROSS_CONF)
	echo cpu_family = \'$(ARCH)\'>>$(CROSS_CONF)
	echo cpu = \'$(CONFIG_TARGET_SUBTARGET)\'>>$(CROSS_CONF)
	echo endian = \'little\'>>$(CROSS_CONF)
	echo [build_machine]>>$(CROSS_CONF)
	echo system = \'linux\'>>$(CROSS_CONF)
	echo cpu_family = \'x86_64\'>>$(CROSS_CONF)
	echo cpu = \'i686\'>>$(CROSS_CONF)
	echo endian = \'little\'>>$(CROSS_CONF)
endef

define Host/Install
	$(INSTALL_DIR) $(STAGING_DIR_HOST)/meson
	$(CP) -R $(PKG_BUILD_DIR)/* $(STAGING_DIR_HOST)/meson/
endef

$(eval $(call HostBuild))
$(eval $(call BuildPackage,meson))
