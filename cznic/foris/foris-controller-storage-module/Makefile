#
# Copyright (C) 2017 CZ.NIC z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-controller-storage-module
PKG_VERSION:=0.2.5
PKG_RELEASE:=1
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/foris-controller-storage-module.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
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
 This is a netmetr module for foris-controller
endef

define Package/$(PKG_NAME)/conffiles
/etc/config/storage
endef

$(eval $(call ForisControllerModule,$(PKG_NAME)))

define Package/$(PKG_NAME)/postinst
#!/bin/sh
set -x
if [ -z "$${IPKG_INSTROOT}" ]; then
	/etc/init.d/foris-controller restart
	/etc/init.d/srv enable
fi
mkdir -p "$${IPKG_INSTROOT}"/srv
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)$(PYTHON3_PKG_DIR) $(1)/usr/libexec $(1)/etc/init.d $(1)/etc/config
	echo -e "config srv 'srv'\\n\\toption uuid ''\\n\\toption old_uuid ''" > $(1)/etc/config/storage
	find $(PKG_INSTALL_DIR)$(PYTHON3_PKG_DIR) -mindepth 1 -maxdepth 1 \( -type f -o -type d \) -exec $(CP) \{\} $(1)$(PYTHON3_PKG_DIR)/ \;
	$(RM) $(1)/usr/lib/python$(PYTHON3_VERSION)/site-packages/foris_controller_modules/__init__.py
	$(RM) $(1)/usr/lib/python$(PYTHON3_VERSION)/site-packages/foris_controller_backends/__init__.py
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/scripts/srv.init $(1)/etc/init.d/srv
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/scripts/format_and_set_srv.sh $(1)/usr/libexec
ifneq ($(CONFIG_RSYNC_xattr),y)
	sed -i 's|\(.*rsync .*\)X\(.*\)|\1\2|' $(1)/etc/init.d/srv
endif
endef

$(eval $(call Py3Package,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_NAME)-src))
