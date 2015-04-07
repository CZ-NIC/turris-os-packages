#
### Copyright (C) 2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
### This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# # #
# #
#

include $(TOPDIR)/rules.mk

PKG_NAME:=uboot-turris
PKG_VERSION:=1
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/uboot-turris
  DEPENDS:=@TARGET_mpc85xx_p2020_nand_TURRISNAND
  TITLE:=uboot-turris
endef

define Build/Prepare
endef

define Build/Compile
endef

define Package/uboot-turris/install
	$(INSTALL_DIR) $(1)/boot
	$(CP) $(TOPDIR)/uboot-static/uboot-mpc85xx-TURRIS1_padding $(1)/boot/u-boot
endef

$(eval $(call BuildPackage,uboot-turris))
