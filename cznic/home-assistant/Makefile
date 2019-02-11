#
# Copyright (C) 2015 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=home-assistant
PKG_VERSION:=0.7.1
PKG_RELEASE:=4
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Pavel Spirek <pavel.spirek@nic.cz>

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/balloob/home-assistant.git
PKG_SOURCE_VERSION:=$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/home-assistant
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Home Automation
  TITLE:=Open-source home automation platform running on Python 3
  DEPENDS:=+python3 +python3-requests +python3-pytz +python3-pyyaml +python3-setuptools
  URL:=https://home-assistant.com/
endef

define Package/home-assistant/conffiles
/etc/config/home-assistant
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,,\
		install --root="$(PKG_INSTALL_DIR)" --prefix="/usr" \
		--single-version-externally-managed \
	)
endef

define Py3Package/home-assistant/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/hass $(1)/usr/bin/hass

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/home-assistant.init $(1)/etc/init.d/home-assistant

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/home-assistant.conf $(1)/etc/config/home-assistant
endef

$(eval $(call Py3Package,home-assistant))
$(eval $(call BuildPackage,home-assistant))
