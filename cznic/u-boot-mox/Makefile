#
## Copyright (C) 2018 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=u-boot-mox
PKG_VERSION:=2018-11-rc1
PKG_RELEASE:=4
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git@gitlab.labs.nic.cz:turris/mox-boot-builder.git
PKG_SOURCE_VERSION:=376ec140d20a1f60ab3a0bf0d4c6608e4a60a7a0
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.xz
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=@TARGET_mvebu_cortexa53_DEVICE_cznic-mox
endef

define Build/Compile
	cd $(PKG_BUILD_DIR); make CROSS_COMPILE=$(TARGET_CROSS) u-boot.bin
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/share/mox
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/u-boot.bin $(1)/usr/share/mox/uboot
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
