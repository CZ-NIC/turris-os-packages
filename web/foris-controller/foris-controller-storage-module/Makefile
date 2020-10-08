#
# Copyright (C) 2017-2020 CZ.NIC z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-controller-storage-module
PKG_VERSION:=0.5
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/foris-controller/foris-controller-storage-module.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk
include ../foris-controller/files/foris-controller-module.mk

define Package/foris-controller-storage-module
  SECTION:=web
  CATEGORY:=Web
  SUBMENU:=Foris Controller
  TITLE:=Foris controller Storage module
  DEPENDS:= \
    +foris-controller \
    +btrfs-progs \
    +coreutils \
    +coreutils-stat \
    +rsync \
    +partx-utils \
    +blkid
  VARIANT:=python3
endef

define Package/foris-controller-storage-module/description
  This is a storage module for foris-controller.
endef

define Package/foris-controller-storage-module/conffiles
/etc/config/storage
endef

define Package/foris-controller-storage-module/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	/etc/init.d/foris-controller restart
	/etc/init.d/srv enable
fi
mkdir -p "$${IPKG_INSTROOT}"/srv
endef

define ForisControllerModule/foris-controller-storage-module/install
	$(INSTALL_DIR) $(1)/usr/libexec $(1)/etc/init.d $(1)/etc/config
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/scripts/format_and_set_srv.sh $(1)/usr/libexec
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/scripts/srv.init $(1)/etc/init.d/srv
	$(INSTALL_DATA) ./files/storage.uci $(1)/etc/config/storage
ifneq ($(CONFIG_RSYNC_xattr),y)
	sed -i 's|\(.*rsync .*\)X\(.*\)|\1\2|' $(1)/etc/init.d/srv
endif
endef

$(eval $(call ForisControllerModule,foris-controller-storage-module))
# call BuildPackage <= assures OWR build system that this is package
