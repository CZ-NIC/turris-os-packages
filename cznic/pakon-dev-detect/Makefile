#
# Copyright (C) 2017 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pakon-dev-detect
PKG_VERSION:=0.1
PKG_RELEASE:=1
PKG_LICENSE:=GPLv2+
PKG_LICENSE_FILES:=COPYING

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/pakon-dev-detect.git
PKG_SOURCE_VERSION:=0d40fc3138eef68ee9ed3ad01d840a62a5d764a1
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
MAINTAINER:=Martin Petracek <martin.petracek@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

define Package/pakon-dev-detect
  TITLE:=pakon-dev-detect
  DEPENDS:=+python3 +python3-setuptools +pakon-guts +ouidb
endef

define Package/pakon-dev-detect/description
 This package provides a utility to detect new devices on LAN (using pakon-guts).
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,,install --prefix=/usr --root=$(PKG_INSTALL_DIR) --single-version-externally-managed)
endef

define Py3Package/pakon-dev-detect/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/pakon-dev-detect.init $(1)/etc/init.d/pakon-dev-detect

	$(INSTALL_DIR) $(1)/usr/share/pakon-dev-detect
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/init_known_macs.sh $(1)/usr/share/pakon-dev-detect/
endef

define Package/pakon-dev-detect/postinst
	[ -f /usr/share/pakon-dev-detect/known_macs ] || /usr/share/pakon-dev-detect/init_known_macs.sh > /usr/share/pakon-dev-detect/known_macs
endef


$(eval $(call Py3Package,pakon-dev-detect))
$(eval $(call BuildPackage,pakon-dev-detect))
