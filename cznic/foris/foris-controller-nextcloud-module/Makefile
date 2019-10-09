#
# Copyright (C) 2019 CZ.NIC z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-controller-nextcloud-module
PKG_VERSION:=0.1
PKG_RELEASE:=3
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/foris-controller-nextcloud-module.git
PKG_SOURCE_VERSION:=5b9d60ff8ffceb99eea418defd5635d45e6ae127
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(BUILD_VARIANT)-$(PKG_NAME)-$(PKG_VERSION)

PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILE:=LICENSE

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk
include ../foris-controller/files/foris-controller-module.mk

PKG_UNPACK:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=\
		+foris-controller +btrfs-progs +coreutils +coreutils-stat +rsync +partx-utils +blkid
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
	VARIANT:=python3
endef

define Package/$(PKG_NAME)/description
 This is a nextcloud module for foris-controller
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	/etc/init.d/foris-controller restart
	/etc/init.d/srv enable
fi
mkdir -p "$${IPKG_INSTROOT}"/srv
endef

define ForisControllerModule/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/libexec $(1)/etc/init.d $(1)/etc/config
endef

$(eval $(call ForisControllerModule,$(PKG_NAME)))
# call BuildPackage <= assures OWR build system that this is package
