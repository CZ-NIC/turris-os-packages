#
# Copyright (C) 2017 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=sentinel-certgen
PKG_VERSION:=1
PKG_RELEASE:=1
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/sentinel/certgen.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=77d0191d4c9360343651ebd5a6ba2790cfd26d0b
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_MAINTAINER:=Martin Petracek <martin.petracek@nic.cz>
PKG_LICENSE:=GPL-3.0

PKG_INSTALL:=0

include $(INCLUDE_DIR)/package.mk

define Package/sentinel-certgen
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Client application of our LE-like automated certification authority.
	TITLE:=sentinel-certgen
	DEPENDS:=+python3-light +python3-six +libatsha204 +python3-cryptography
endef

define Package/$(PKG_NAME)/description
  Client application to get Turris::Sentinel certificates
endef

define Build/Compile
  true
endef

define Build/Install
  true
endef


define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/sentinel
	$(INSTALL_BIN) ./files/ca.pem $(1)/etc/sentinel/ca.pem
	$(INSTALL_DIR) $(1)/usr/libexec
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/certgen.py $(1)/usr/libexec/sentinel_certgen.py
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
