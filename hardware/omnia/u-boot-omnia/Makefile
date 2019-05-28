#
## Copyright (C) 2018 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=u-boot-omnia
PKG_VERSION:=2019-04
PKG_RELEASE:=4
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git@gitlab.labs.nic.cz:turris/turris-omnia-uboot.git
PKG_SOURCE_VERSION:=a66dc6db5ec01bee4c88b23ae1a53f8e96de041a
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.xz
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=@TARGET_mvebu_cortexa9_DEVICE_cznic_turris-omnia
endef

define Build/Compile
	cd $(PKG_BUILD_DIR); make CROSS_COMPILE=$(TARGET_CROSS) turris_omnia_defconfig
	cd $(PKG_BUILD_DIR); make CROSS_COMPILE=$(TARGET_CROSS) u-boot-spl.kwb
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/share/omnia
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/u-boot-spl.kwb $(1)/usr/share/omnia/uboot-devel
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
