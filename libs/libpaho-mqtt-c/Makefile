# Copyright (C) 2018-2020 CZ.NIC, z.s.p.o.
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libpaho-mqtt-c
PKG_VERSION:=1.3.1
PKG_RELEASE=1

PKG_SOURCE:=v$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/eclipse/paho.mqtt.c/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=7b4eed66ae3df3613629139c0df28b16abfa4e0927bd17360027d936784aa55e
PKG_BUILD_DIR:=$(BUILD_DIR)/paho.mqtt.c-$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=EPL-1.0
PKG_LICENSE_FILES:=LICENSE

CMAKE_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/libpaho-mqtt-c
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Eclipse Paho MQTT C library
  DEPENDS:=+libopenssl +libpthread
endef

CMAKE_OPTIONS += -DPAHO_WITH_SSL=TRUE

define Build/InstallDev
	$(CP) $(PKG_INSTALL_DIR)/* $(1)/
endef

define Package/libpaho-mqtt-c/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libpaho-*.so* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libpaho-mqtt-c))

