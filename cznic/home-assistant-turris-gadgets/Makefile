#
# Copyright (C) 2015 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=home-assistant-turris-gadgets
PKG_VERSION:=1
PKG_RELEASE:=1
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Pavel Spirek <pavel.spirek@nic.cz>

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/home-assistant-turris-gadgets.git
PKG_SOURCE_VERSION:=package-v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/home-assistant-turris-gadgets
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Home Automation
  TITLE:=Turris Gadgets support for HA
  DEPENDS:=home-assistant +python3-pydispatcher +python3-pyserial
endef

define Package/home-assistant-turris-gadgets/description
 Support of Turris Gadgets in Home Assistant home automation platform.
endef

# empty compile block
define Build/Compile
endef

define Package/home-assistant-turris-gadgets/install
	$(INSTALL_DIR) $(1)/usr/lib/$(PYTHON3)/site-packages
	$(CP) $(PKG_BUILD_DIR)/homeassistant $(1)/usr/lib/$(PYTHON3)/site-packages
endef

$(eval $(call BuildPackage,home-assistant-turris-gadgets))
