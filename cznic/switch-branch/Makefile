#
## Copyright (C) 2017-2018 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=switch-branch
PKG_VERSION:=2.1.4
PKG_RELEASE:=1
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
endef

define Build/Compile
	true
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/switch-branch $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/updater/conf.d
	$(INSTALL_CONF) ./files/updater.lua $(1)/etc/updater/conf.d/switch-branch.lua
endef

define Package/$(PKG_NAME)/postinst
if [ -z "$$IPKG_INSTROOT" ]; then
	switch-branch --verify --force
fi
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
