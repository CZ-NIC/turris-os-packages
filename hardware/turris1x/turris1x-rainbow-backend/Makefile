#
## Copyright (C) 2022 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=turris1x-rainbow-backend
PKG_VERSION:=0.1.0
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/rainbow-ng.git
PKG_MIRROR_HASH:=86d252b5a927f6803e40e7a032097426e7b54be1e6e485789caa072c7b95f908
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/turris1x-rainbow-backend
  TITLE:=turris1x-rainbow-backend
  DEPENDS:=\
    @TARGET_mpc85xx_p2020_DEVICE_cznic_turris1x \
    +rainbow-button-sync \
    +rainbow-animator
  PROVIDES:=rainbow-backend
endef

Build/Compile:=:

define Package/turris1x-rainbow-backend/install
	cd $(PKG_BUILD_DIR); make turris1x-install DESTDIR=$(1)
endef

$(eval $(call BuildPackage,turris1x-rainbow-backend))
