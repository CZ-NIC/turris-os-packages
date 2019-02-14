#
## Copyright (C) 2017 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=libatsha204
PKG_PYTHON_NAME:=python3-$(PKG_NAME)
PKG_VERSION:=28.1
PKG_RELEASE:=1
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/libatsha204.git
PKG_SOURCE_VERSION:=9f183596983d0f4d7257ad9189547f9414a94be3
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
PKG_BUILD_DEPENDS:=python3

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	PROVIDES:=turris-otp
	DEPENDS:=+libopenssl +libunbound 
endef

define Package/$(PKG_NAME)-emul
	TITLE:=$(PKG_NAME)-emul
	PROVIDES:=$(PKG_NAME) turris-otp
	DEPENDS:=+libopenssl +libunbound 
endef


define Build/Compile
	mkdir -p $(PKG_BUILD_DIR)/real/bin $(PKG_BUILD_DIR)/real/lib
ifdef CONFIG_TARGET_mvebu_Turris-Omnia
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS) NO_DOC=1 USE_LAYER=USE_LAYER_NI2C DEFAULT_NI2C_DEV_PATH=NI2C_DEV_PATH_OMNIA VERBOSE=1 bin/atsha204cmd
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/atsha204cmd $(PKG_BUILD_DIR)/real/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lib/libatsha204.so $(PKG_BUILD_DIR)/real/lib
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS) NO_DOC=1 USE_LAYER=USE_LAYER_NI2C DEFAULT_NI2C_DEV_PATH=NI2C_DEV_PATH_OMNIA VERBOSE=1 clean
endif
ifdef CONFIG_TARGET_mpc85xx_p2020_nand_TURRISNAND
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS) NO_DOC=1 USE_LAYER=USE_LAYER_NI2C DEFAULT_NI2C_DEV_PATH=NI2C_DEV_PATH_TURRIS VERBOSE=1 bin/atsha204cmd
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/atsha204cmd $(PKG_BUILD_DIR)/real/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lib/libatsha204.so $(PKG_BUILD_DIR)/real/lib
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS) NO_DOC=1 USE_LAYER=USE_LAYER_NI2C DEFAULT_NI2C_DEV_PATH=NI2C_DEV_PATH_TURRIS VERBOSE=1 clean
endif
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS) NO_DOC=1 USE_LAYER=USE_LAYER_EMULATION CONFIG_PATH=/etc/atsha.sw VERBOSE=1 bin/atsha204cmd
	$(call Build/Compile/Py3Mod,./src/python/, install --prefix="/usr" --root="$(PKG_INSTALL_DIR)", CFLAGS+=" -I$(PKG_BUILD_DIR)/src/libatsha204/" LDFLAGS+=" -L$(PKG_BUILD_DIR)/src/libatsha204/")
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/real/bin/atsha204cmd $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/real//lib/libatsha204.so $(1)/usr/lib/

	if [ "$$$$TARGET_BOARD" != turris ] ; then $(INSTALL_DIR) $(1)/etc/init.d ; $(INSTALL_BIN) ./files/libatsha204.init $(1)/etc/init.d/libatsha204 ; fi
endef

define Package/$(PKG_NAME)-emul/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/atsha204cmd $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lib/libatsha204.so $(1)/usr/lib/
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
	DEPENDS:=+python3-light +libatsha204
endef

define Package/$(PKG_PYTHON_NAME)/install
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)
	$(CP) $(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* $(1)$(PYTHON_PKG_DIR)
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_NAME)-emul))
$(eval $(call BuildPackage,$(PKG_PYTHON_NAME)))
