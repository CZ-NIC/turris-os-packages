#
# Copyright (C) 2015 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=domoticz-turris-gadgets
PKG_REV:=2563-gadgets-11-g7b63085
PKG_VERSION:=2.${PKG_REV}
PKG_RELEASE:=1
PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=License.txt
PKG_MAINTAINER:=Pavel Spirek <pavel.spirek@nic.cz>

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=http://gitlab.nic.cz/turris/domoticz-turris-gadgets.git
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

CMAKE_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/domoticz-turris-gadgets
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Home Automation
  CONFLICTS:=domoticz
  TITLE:=Domoticz Home Automation for Turris Gadgets
  DEPENDS:=+zlib +libusb-1.0 +libusb-compat +libcurl +libsqlite3 +libopenssl +boost-system +boost-thread +boost-date_time +lm-sensors
  URL:=https://domoticz.com/
endef

define Package/domoticz-turris-gadgets/description
  Domoticz is a Home Automation System that lets you monitor and configure various devices like:
  Lights, Switches, various sensors/meters like Temperature, Rain, Wind, UV, Electra, Gas, Water and much more.
  Notifications/Alerts can be sent to any mobile device.
endef

CMAKE_OPTIONS += \
	-DCMAKE_BUILD_TYPE=Release . \
	-DCPACK_STRIP_FILES=1

define Build/Prepare
	$(call Build/Prepare/Default)
	echo "#define SVNVERSION  $(PKG_REV)-$(PKG_RELEASE)" > $(PKG_BUILD_DIR)/svnversion.h
endef

define Package/domoticz-turris-gadgets/conffiles
/etc/config/domoticz
endef

define Package/domoticz-turris-gadgets/install
	$(INSTALL_DIR) $(1)/usr/share/domoticz
	$(CP) $(PKG_INSTALL_DIR)/opt/domoticz/svnversion.h $(1)/usr/share/domoticz/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/domoticz/domoticz $(1)/usr/share/domoticz/
	$(CP) $(PKG_INSTALL_DIR)/opt/domoticz/www $(1)/usr/share/domoticz/

	$(INSTALL_DIR) $(1)/usr/share/domoticz/scripts/lua/
	$(CP) $(PKG_INSTALL_DIR)/opt/domoticz/scripts/lua/ $(1)/usr/share/domoticz/lua/

	$(INSTALL_DIR) $(1)/usr/bin/
	ln -sf ../share/domoticz/domoticz $(1)/usr/bin/domoticz

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/domoticz.init $(1)/etc/init.d/domoticz

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/domoticz.conf $(1)/etc/config/domoticz
endef

$(eval $(call BuildPackage,domoticz-turris-gadgets))
