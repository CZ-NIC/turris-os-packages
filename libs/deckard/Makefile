#
# Copyright (C) 2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=deckard
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/knot/deckard.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE_VERSION:=a179ddb1b5b67a61dc89a97833520485c49f784b
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_MIRROR_HASH:=18aafa912e49d679fb62b434bda7d23d0d2ddd6b150dc45ad18ce077c82a76be

PKG_MAINTAINER:=Jan Pavlinec <jan.pavlinec@nic.cz>
PKG_LICENSE:=BSD-2-Clause
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/deckard
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=DNS test frameowrk
  URL:=https://gitlab.labs.nic.cz/knot/deckard
  DEPENDS:=+augeas +pytest
endef

define Build/Configure
endef

define Build/Compile
endef

define Build/Install
endef

define Package/deckard/description
  Deckard is a framework which implements different DNS tests mainly inspired by RFC 8027.
endef

define Package/deckard/install
	$(INSTALL_DIR) $(1)/usr/libexec/deckard
	$(CP) $(PKG_BUILD_DIR)/{ci,configs,pydnstest,sets,template,tests,tools} $(1)/usr/libexec/deckard/
	$(CP) $(PKG_BUILD_DIR)/*.py $(1)/usr/libexec/deckard/
	$(CP) $(PKG_BUILD_DIR)/*.sh $(1)/usr/libexec/deckard/
	$(CP) $(PKG_BUILD_DIR)/*.ini $(1)/usr/libexec/deckard/
	$(CP) $(PKG_BUILD_DIR)/{LICENSE,Makefile,platform.mk,pylintrc,README.rst,requirements.txt} $(1)/usr/libexec/deckard/
endef

$(eval $(call BuildPackage,deckard))
