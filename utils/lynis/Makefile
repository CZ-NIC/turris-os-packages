#
# Copyright (C) 2017 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#

include $(TOPDIR)/rules.mk

PKG_NAME:=lynis
PKG_VERSION:=2.5.7
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://cisofy.com/files
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_MD5SUM:=95a6b8249b729d6c431377015c53724d3d267b74c2c9e5596a4d1c59c15df64c

PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_MAINTAINER:=Jan Pavlinec <jan.pavlinec@nic.cz>
PKG_LICENSE:=GPL-3.0

PKG_INSTALL:=0

include $(INCLUDE_DIR)/package.mk

define Package/lynis
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=Lynis
	URL:=https://cisofy.com/lynis/
	DEPENDS:=+procps-ng-ps +procps-ng-pgrep +wget
endef

define Package/$(PKG_NAME)/description
  Lynis is security auditing tool. Used to evaluate the security defenses of Linux and Unix-based systems.
endef

define Build/Compile
endef

define Build/Install
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/lynis
	$(CP) $(PKG_BUILD_DIR)/default.prf $(1)/etc/lynis/

	$(INSTALL_DIR) $(1)/usr/share/lynis
	$(CP) $(PKG_BUILD_DIR)/{*.md,*.prf} $(1)/usr/share/lynis/
	$(CP) $(PKG_BUILD_DIR)/{lynis,lynis.8,FAQ,INSTALL,LICENSE,README} $(1)/usr/share/lynis/

	$(INSTALL_DIR) $(1)/usr/bin
	$(LN) /usr/share/lynis/lynis $(1)/usr/bin/lynis

	$(INSTALL_DIR) $(1)/usr/share/lynis/extras/
	$(CP) $(PKG_BUILD_DIR)/extras/* $(1)/usr/share/lynis/extras/

	$(INSTALL_DIR) $(1)/usr/share/lynis/include/
	$(CP) $(PKG_BUILD_DIR)/include/* $(1)/usr/share/lynis/include/

	$(INSTALL_DIR) $(1)/usr/share/lynis/plugins/
	$(CP) $(PKG_BUILD_DIR)/plugins/* $(1)/usr/share/lynis/plugins/

	$(INSTALL_DIR) $(1)/usr/share/lynis/db/
	$(CP) $(PKG_BUILD_DIR)/db/* $(1)/usr/share/lynis/db/
endef

$(eval $(call BuildPackage,lynis))
