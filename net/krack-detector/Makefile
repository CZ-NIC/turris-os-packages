#
# Copyright (C) 2017 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

PKG_RELRO_FULL:=0

include $(TOPDIR)/rules.mk

PKG_NAME:=krack-detector
PKG_VERSION:=8715dd19ef920dd5e071f0a1e3416f64f90f7455
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/securingsam/krackdetector.git
PKG_SOURCE_VERSION:=$(PKG_VERSION)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=MIT License

PKG_INSTALL:=0

include $(INCLUDE_DIR)/package.mk

define Package/krack-detector
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=wireless
	TITLE:=KRACK attack detector
	URL:=https://github.com/securingsam/krackdetector
	DEPENDS=+python +python-ctypes +hostapd-utils
endef

define Build/Compile
endef

define Build/Install
endef

define Package/$(PKG_NAME)/description
  KRACK Detector is a Python script to detect possible KRACK attacks against client devices on your network.
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/krack_detect.py $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc/init.d/

	$(INSTALL_BIN) $(PKG_BUILD_DIR)/krack_detect.py $(1)/usr/bin/
	$(INSTALL_BIN) ./files/krack-detector.init $(1)/etc/init.d/krack-detector

	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF) ./files/krack-detector.config $(1)/etc/config/krack-detector
endef

$(eval $(call BuildPackage,krack-detector))
