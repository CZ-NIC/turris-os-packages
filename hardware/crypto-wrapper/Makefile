#
## Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=crypto-wrapper
PKG_VERSION:=0.4
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/crypto-wrapper.git
PKG_MIRROR_HASH:=1fb45c61479a17e20601ad91c48ce00f358b1ad5f5f9b49ba3e6717403d9ceb7
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE.md

include $(INCLUDE_DIR)/package.mk

define Package/crypto-wrapper
  TITLE:=Crypto Wrapper CLI
  DEPENDS:=+turris-otp
endef

define Package/crypto-wrapper/description
  Tool to unify interface for cryptographic entities on Turris 1.x, Omnia and MOX
endef

Build/Compile:=:

define Package/crypto-wrapper/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/crypto-wrapper.sh $(1)/usr/bin/crypto-wrapper
endef

$(eval $(call BuildPackage,crypto-wrapper))
