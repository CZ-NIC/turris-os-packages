#
## Copyright (C) 2014-2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=getmac
PKG_VERSION:=1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/misc.git
PKG_SOURCE_VERSION:=5b243eee1e4d5769dfb8260335118ec626849e3b

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/getmac
  TITLE:=Get MAC
  DEPENDS:=@TARGET_mpc85xx_p2020_DEVICE_turris1x
endef

define Build/Compile
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR)/getmac $(MAKE_FLAGS)
endef

define Package/getmac/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/getmac/getmac $(1)/usr/bin/
endef

$(eval $(call BuildPackage,getmac))
