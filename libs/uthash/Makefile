#
## Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=uthash
PKG_VERSION:=2.1.0
PKG_RELEASE:=1

PKG_SOURCE:=v$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/troydhanson/uthash/archive
PKG_HASH:=152ccd8e64d0f495377232e3964d06c7ec8bb8c3fbd3217f8a5702614f9a669e
PKG_BUILD_DIR:=$(BUILD_DIR)/uthash-$(PKG_VERSION)
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/host-build.mk
include $(INCLUDE_DIR)/package.mk

Build/Compile:=:
Host/Compile:=:

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_BUILD_DIR)/include/* $(1)/usr/include/
endef

define Host/Install
	$(INSTALL_DIR) $(STAGING_DIR_HOST)/usr/include
	$(CP) $(HOST_BUILD_DIR)/include/* $(STAGING_DIR_HOST)/usr/include/
endef


$(eval $(call HostBuild))
$(eval $(call Build/DefaultTargets))
