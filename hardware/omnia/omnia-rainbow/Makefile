#
## Copyright (C) 2016-2021 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=omnia-rainbow
PKG_VERSION:=3.1
PKG_RELEASE:=3

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/rainbow_omnia.git
PKG_MIRROR_HASH:=34b82a94837caf928f472cf3da82d8e17a1bdfcd503532bede0cacb7bac964c4
PKG_SOURCE_VERSION:=d4ded015bd5a400059ea20f2234a311e749dc519

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/omnia-rainbow
  TITLE:=omnia-rainbow
  URL:=https://gitlab.nic.cz/turris/rainbow_omnia
  DEPENDS:=@TARGET_mvebu_cortexa9_DEVICE_cznic_turris-omnia
endef

define Build/Compile
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS)
endef

define Package/omnia-rainbow/install
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/rainbow $(1)/usr/bin/omnia-rainbow
endef

$(eval $(call BuildPackage,omnia-rainbow))
