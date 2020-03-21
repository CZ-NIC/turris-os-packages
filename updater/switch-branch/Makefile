#
## Copyright (C) 2017-2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=switch-branch
PKG_VERSION:=2.4.1
PKG_RELEASE:=2

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/switch-branch
	TITLE:=Switch branch
endef

Build/Compile:=:

define Package/switch-branch/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/switch-branch $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/updater/conf.d
	$(INSTALL_CONF) ./files/updater.lua $(1)/etc/updater/conf.d/switch-branch.lua
endef

define Package/switch-branch/postinst
if [ -z "$$IPKG_INSTROOT" ]; then
	switch-branch --verify --force
fi
endef

$(eval $(call BuildPackage,switch-branch))
