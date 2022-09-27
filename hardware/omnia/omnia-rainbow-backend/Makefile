#
## Copyright (C) 2022 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=omnia-rainbow-backend
PKG_VERSION:=0.1.1
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/rainbow-ng.git
PKG_MIRROR_HASH:=9d9e126949dd16bd52cc9fe520c5e834a637cbdb124c24d41589565cddda8073
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=COPYING

include $(INCLUDE_DIR)/package.mk

define Package/omnia-rainbow-backend
  TITLE:=omnia-rainbow-backend
  DEPENDS:=\
    @TARGET_mvebu_cortexa9_DEVICE_cznic_turris-omnia \
    +rainbow-button-sync \
    +rainbow-animator
  PROVIDES:=rainbow-backend
endef

Build/Compile:=:

define Package/omnia-rainbow-backend/install
	cd $(PKG_BUILD_DIR); make omnia-install DESTDIR=$(1)
endef

$(eval $(call BuildPackage,omnia-rainbow-backend))
