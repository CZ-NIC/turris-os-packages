# Copyright (C) 2018 CZ.NIC, z.s.p.o.
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libpaho-mqtt-c
PKG_VERSION:=1.2.0
PKG_RELEASE=1

PKG_SOURCE:=v$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/eclipse/paho.mqtt.c/archive/
PKG_BUILD_DIR:=$(BUILD_DIR)/paho.mqtt.c-$(PKG_VERSION)
PKG_MD5SUM:=6897eea98dc0a0e6fd6bed4dd3a4bbe5
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf
PKG_BUILD_PARALLEL:=1
PKG_LICENSE:=EPL-1.0

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk
include $(INCLUDE_DIR)/cmake.mk

CMAKE_OPTIONS += -DPAHO_WITH_SSL=TRUE -DPAHO_BUILD_DOCUMENTATION=FALSE -DPAHO_BUILD_SAMPLES=FALSE

define Package/libpaho-mqtt-c
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Eclipse Paho MQTT C library
  DEPENDS:=+libopenssl
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) CFLAGS="$(TARGET_CFLAGS) $(EXTRA_CFLAGS) $(TARGET_CPPFLAGS) $(EXTRA_CPPFLAGS)"
endef

define Build/InstallDev
	$(CP) $(PKG_INSTALL_DIR)/* $(1)/
endef

define Package/libpaho-mqtt-c/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libpaho-*.so* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libpaho-mqtt-c))
