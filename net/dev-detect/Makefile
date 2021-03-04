#
# Copyright (C) 2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dev-detect
PKG_VERSION:=0.3.1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/dev-detect.git
PKG_MIRROR_HASH:=baa22230b64cb50cd78d2d994e69f6ea571665deb76953f91ab3bde2dc627256
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/dev-detect
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Dev-detect
  DEPENDS:= \
        +python3-light \
        +python3-pyroute2 \
        +python3-logging \
        +python3-sqlite3 \
        +python3-uci \
        +ouidb
  VARIANT:=python3
endef

define Package/dev-detect/description
  Small utility to detect devices on local network
endef

define Py3Package/dev-detect/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/dev-detect.init $(1)/etc/init.d/dev-detect

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/dev-detect.uci $(1)/etc/config/dev-detect

	$(INSTALL_DIR) $(1)/usr/libexec
	$(INSTALL_BIN) ./files/notify_new_device.sh $(1)/usr/libexec/

	$(INSTALL_DIR) $(1)/srv/dev-detect
endef

$(eval $(call Py3Package,dev-detect))
$(eval $(call BuildPackage,dev-detect))
$(eval $(call BuildPackage,dev-detect-src))
