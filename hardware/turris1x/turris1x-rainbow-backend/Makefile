#
## Copyright (C) 2022 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=turris1x-rainbow-backend
PKG_VERSION:=0.1.1
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/rainbow-ng.git
PKG_MIRROR_HASH:=0171626261439a81b4ae84d8a3a7ae94f0997be8b7a9317f88a41c111fe04b1d
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=COPYING

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
