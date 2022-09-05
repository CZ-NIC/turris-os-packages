#
## Copyright (C) 2018-2022 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=omnia-uboot
PKG_VERSION:=$(if $(DUMP),x,$(shell sed -ne 's#PKG_VERSION:=##p' $(TOPDIR)/package/boot/uboot-mvebu/Makefile))
PKG_RELEASE:=$(AUTORELEASE)

PKG_BUILD_DEPENDS:=uboot-mvebu

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=README

include $(INCLUDE_DIR)/package.mk

define Package/omnia-uboot
  TITLE:=U-boot for Turris Omnia
  DEPENDS:=@TARGET_mvebu_cortexa9_DEVICE_cznic_turris-omnia
  PROVIDES:=u-boot-omnia
endef

define Package/omnia-uboot/description
  U-boot image for Turris Omnia
endef

define Build/Configure
  true
endef

define Build/Compile
  true
endef

define Package/omnia-uboot/install
	$(INSTALL_DIR) $(1)/usr/share/omnia
	$(CP) $(STAGING_DIR_IMAGE)/omnia-u-boot-spl.kwb $(1)/usr/share/omnia/uboot-devel
endef

$(eval $(call BuildPackage,omnia-uboot))
