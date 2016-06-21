#
## Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=libatsha204
PKG_PYTHON_NAME:=python-$(PKG_NAME)
PKG_VERSION:=24
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/libatsha204.git
PKG_SOURCE_VERSION:=ca528f9fe59a3ee07324ce5c6a45f82c8d4459e8
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Michal Vaner <michal.vaner@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
PKG_BUILD_DEPENDS:=python

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+libopenssl +libunbound 
endef

ifdef CONFIG_TARGET_mvebu_Turris-Omnia
define Build/Compile
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS) NO_DOC=1 USE_LAYER=USE_LAYER_NI2C DEFAULT_NI2C_DEV_PATH=NI2C_DEV_PATH_OMNIA VERBOSE=1 bin/atsha204cmd
	$(call Build/Compile/PyMod,./src/python/, install --prefix="/usr" --root="$(PKG_INSTALL_DIR)", CFLAGS+=" -I$(PKG_BUILD_DIR)/src/libatsha204/" LDFLAGS+=" -L$(PKG_BUILD_DIR)/src/libatsha204/")
endef
else
ifdef CONFIG_TARGET_mpc85xx_p2020_nand_TURRISNAND
define Build/Compile
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS) NO_DOC=1 USE_LAYER=USE_LAYER_NI2C DEFAULT_NI2C_DEV_PATH=NI2C_DEV_PATH_TURRIS VERBOSE=1 bin/atsha204cmd
	$(call Build/Compile/PyMod,./src/python/, install --prefix="/usr" --root="$(PKG_INSTALL_DIR)", CFLAGS+=" -I$(PKG_BUILD_DIR)/src/libatsha204/" LDFLAGS+=" -L$(PKG_BUILD_DIR)/src/libatsha204/")
endef
else
define Build/Compile
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS) NO_DOC=1 USE_LAYER=USE_LAYER_EMULATION CONFIG_PATH=/etc/atsha.sw VERBOSE=1 bin/atsha204cmd
	$(call Build/Compile/PyMod,./src/python/, install --prefix="/usr" --root="$(PKG_INSTALL_DIR)", CFLAGS+=" -I$(PKG_BUILD_DIR)/src/libatsha204/" LDFLAGS+=" -L$(PKG_BUILD_DIR)/src/libatsha204/")
endef
endif
endif

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/atsha204cmd $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lib/libatsha204.so $(1)/usr/lib/

	if [ "$$$$TARGET_BOARD" != turris ] ; then $(INSTALL_DIR) $(1)/etc/init.d ; $(INSTALL_BIN) ./files/libatsha204.init $(1)/etc/init.d/libatsha204 ; fi
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

# If it doesn't exist, it means we have real atsha chip, so no need to generate anything
if [ -z "$${IPKG_INSTROOT}" ] && [ -e /etc/init.d/libatsha204 ] ; then
	/etc/init.d/libatsha204 start
fi
# Else - we hope it gets started by default if its in the buildroot.
endef

define Package/$(PKG_NAME)/prerm
# Remove the script if it is there.
if [ -e /etc/init.d/libatsha204 ] ; then /etc/init.d/libatsha204 disable ; fi
endef


define Package/$(PKG_PYTHON_NAME)
	TITLE:=$(PKG_PYTHON_NAME)
	DEPENDS:=+python +libatsha204
endef

define Package/$(PKG_PYTHON_NAME)/install
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* $(1)$(PYTHON_PKG_DIR)
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_PYTHON_NAME)))
