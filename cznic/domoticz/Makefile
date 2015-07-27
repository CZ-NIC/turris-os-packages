#
# Copyright (C) 2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_REV:=2563
PKG_NAME:=domoticz
PKG_VERSION:=2.0.${PKG_REV}

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=http://gitlab.labs.nic.cz/turris/domoticz-turris-gadgets.git
PKG_SOURCE_VERSION:=67d29520e55a558be93a6dc5ea757ba53d4dc25a
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Pavel Spirek <pavel.spirek@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

CMAKE_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/domoticz
  SECTION:=irimi
  CATEGORY:=AudiculaPi
  TITLE:=Domoticz Home Automation 
  DEPENDS:=+zlib +libusb-1.0 +libusb-compat +libcurl +libsqlite3 +libopenssl +boost-system +boost-thread +boost-date_time +DOMOTICZ_OZW_SUPPORT:openzwave +DOMOTICZ_WIREPI_SUPPORT:wiringpi +DOMOTICZ_RPITOOLS_SUPPORT:userland
  URL:=https://domoticz.com/
  MAINTAINER:=irimi <irimi@gmx.de>
endef

define Package/domoticz/description
  Domoticz is a Home Automation System that lets you monitor and configure various devices like: 
  Lights, Switches, various sensors/meters like Temperature, Rain, Wind, UV, Electra, Gas, Water and much more. 
  Notifications/Alerts can be sent to any mobile device.
endef

define Package/domoticz/config
  menu "Configuration"
  depends on PACKAGE_domoticz
  source "$(SOURCE)/Config.in"
  endmenu
endef
        
CMAKE_OPTIONS += \
	-DCMAKE_BUILD_TYPE=Release . \
	-DCPACK_STRIP_FILES=1
#	-DDEBUG=1

define Package/domoticz/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/opt/domoticz
	$(CP) $(PKG_INSTALL_DIR)/opt/domoticz/domoticz $(1)/opt/domoticz/
	$(CP) $(PKG_INSTALL_DIR)/opt/domoticz/svnversion.h $(1)/opt/domoticz/
	$(CP) $(PKG_INSTALL_DIR)/opt/domoticz/www $(1)/opt/domoticz/
	$(CP) $(PKG_INSTALL_DIR)/opt/domoticz/Config $(1)/opt/domoticz/
	$(CP) $(PKG_INSTALL_DIR)/opt/domoticz/scripts $(1)/opt/domoticz/
	$(INSTALL_BIN) ./files/domoticz.init $(1)/etc/init.d/domoticz
endef

$(eval $(call BuildPackage,domoticz))
