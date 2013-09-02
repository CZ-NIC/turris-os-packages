#
## Copyright (C) 2013 CZ.NIC z.s.p.o. <michal.vaner@nic.cz>
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=libatsha204
PKG_VERSION:=7
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=ssh://git@git.nic.cz/router/libatsha204
PKG_SOURCE_VERSION:=a22ce83204c3ca8b3df5d253770807d7d96acc6a
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Michal Vaner <michal.vaner@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+libopenssl +libunbound
endef

define Build/Compile
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS) NO_DOC=1 USE_LAYER=USE_LAYER_EMULATION CONFIG_PATH=/etc/atsha.sw
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/atsha204cmd $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lib/libatsha204.so $(1)/usr/lib/

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/libatsha204.init $(1)/etc/init.d/libatsha204
	$(INSTALL_BIN) ./files/dnssec-root.key $(1)/etc/dnssec-root.key
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/libatsha204/atsha204.h $(1)/usr/include

	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lib/libatsha204.so $(1)/usr/lib/
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh

# If we are directly on the device, the variable is empty. Generate the
# config right away. If it is non-empty, it is in the buildroot and we
# need to schedule the generation for the first start of the device.
if [ -z "$${IPKG_INSTROOT}" ] ; then
	/etc/init.d/libatsha204 start
fi
# Else - we hope it gets started by default if its in the buildroot.
endef

define Package/$(PKG_NAME)/prerm
# Remove the script if it is there.
/etc/init.d/libatsha204 disable
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
