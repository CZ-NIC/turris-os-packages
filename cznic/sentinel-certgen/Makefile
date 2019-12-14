#
# Copyright (C) 2018-2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=sentinel-certgen
PKG_VERSION:=6.1.3
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/sentinel/certgen.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

define Package/sentinel-certgen
	TITLE:=sentinel-certgen
	URL:=https://gitlab.labs.nic.cz/turris/sentinel/certgen
	DEPENDS:=+python3-light +python3-six +python3-requests +python3-cryptography +crypto-wrapper
	VARIANT:=python3
endef

define Package/$(PKG_NAME)/description
	Client application for automated passwords and certificates retrieval
endef

define Py3Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/sbin/
endef

$(eval $(call Py3Package,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_NAME)))
