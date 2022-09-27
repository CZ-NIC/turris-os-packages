#
## Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=uthash
PKG_VERSION:=2.3.0
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE:=v$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/troydhanson/uthash/archive
PKG_HASH:=e10382ab75518bad8319eb922ad04f907cb20cccb451a3aa980c9d005e661acc

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
