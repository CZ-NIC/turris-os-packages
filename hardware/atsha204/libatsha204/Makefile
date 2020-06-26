#
## Copyright (C) 2017-2020 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=libatsha204
PKG_VERSION:=29.2
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/libatsha204.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/libatsha204
  TITLE:=libatsha204
  URL:=https://gitlab.nic.cz/turris/libatsha204
  PROVIDES:=turris-otp
  DEPENDS:=+libopenssl +libunbound
  DEPENDS+=@(TARGET_mvebu_cortexa9_DEVICE_cznic_turris-omnia||TARGET_mpc85xx_p2020_DEVICE_turris1x)
  VARIANT:=real
endef

define Package/libatsha204-emul
  TITLE:=libatsha204-emul
  PROVIDES:=libatsha204 turris-otp
  DEPENDS:=+libopenssl +libunbound
  VARIANT:=emul
endef

MAKE_FLAGS += NO_DOC=1

ifeq ($(BUILD_VARIANT),real)
  MAKE_FLAGS += USE_LAYER=USE_LAYER_NI2C
  ifeq ($(CONFIG_TARGET_mvebu_cortexa9_DEVICE_cznic_turris-omnia),y)
    MAKE_FLAGS += DEFAULT_NI2C_DEV_PATH=NI2C_DEV_PATH_OMNIA
  else ifeq ($(CONFIG_TARGET_mpc85xx_p2020_DEVICE_turris1x),y)
    MAKE_FLAGS += DEFAULT_NI2C_DEV_PATH=NI2C_DEV_PATH_TURRIS
  endif
endif
ifeq ($(BUILD_VARIANT),emul)
  MAKE_FLAGS += USE_LAYER=USE_LAYER_EMULATION
endif

define Build/Compile
	$(call Build/Compile/Default,bin/atsha204cmd)
endef

define Common/install
	$(INSTALL_DIR) $(1)/usr/bin $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/atsha204cmd $(1)/usr/bin/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/lib/libatsha204.so $(1)/usr/lib/
endef

define Package/libatsha204/install
	$(call Common/install,$(1))

	$(INSTALL_DIR) $(1)/lib/preinit
	$(INSTALL_DATA) ./files/atsha204-feed-entropy.preinit $(1)/lib/preinit/81_atsha204_feed_entropy

	# Note: This script is here for libatsha204-emul. When this package is
	# replaced with emul version then this config is used.
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/uci-defaults $(1)/etc/uci-defaults/50-libatsha204
endef

define Package/libatsha204-emul/install
	$(call Common/install,$(1))
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include $(1)/usr/lib
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/libatsha204/atsha204.h $(1)/usr/include
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/lib/libatsha204.so $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libatsha204))
$(eval $(call BuildPackage,libatsha204-emul))
