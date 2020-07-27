#
## Copyright (C) 2018-2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=turris-diagnostics
PKG_VERSION:=12.3.1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/diagnostics.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/turris-diagnostics
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Turris Diagnostics
  DEPENDS:=+lsblk +socat +crypto-wrapper +gettext-tools
endef

define Package/turris-diagnostics/description
  Obtains diagnostics which are useful for troubleshooting of turris related functionality.
endef

Build/Compile:=:

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/share/locale/
	$(CP) -r $(PKG_BUILD_DIR)/locale/* $(1)/usr/share/locale/
	$(RM) -rf $(1)/usr/share/locale/*.pot
	$(RM) -rf $(1)/usr/share/locale/*/LC_MESSAGES/*.po*

	$(INSTALL_DIR) $(1)/usr/share/diagnostics/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/diagnostics.sh $(1)/usr/share/diagnostics/diagnostics.sh

	$(INSTALL_DIR) $(1)/usr/share/diagnostics/modules
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/modules/module.sh $(1)/usr/share/diagnostics/modules/module.sh
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/modules/*.module $(1)/usr/share/diagnostics/modules/
endef

$(eval $(call BuildPackage,turris-diagnostics))
