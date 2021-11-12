#
## Copyright (C) 2021 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=omnia-rainbow-backend
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/omnia-rainbow-backend
  TITLE:=omnia-rainbow-backend
  DEPENDS:=\
    @TARGET_mvebu_cortexa9_DEVICE_cznic_turris-omnia \
    +rainbow-button-sync \
    +rainbow-animator
  PROVIDES:=rainbow-backend
endef

Build/Compile:=:

define Package/omnia-rainbow-backend/install
	$(INSTALL_DIR) $(1)/usr/share
	$(INSTALL_DATA) ./files/backend.sh $(1)/usr/libexec/rainbow/
	$(INSTALL_DATA) ./files/animator_backend.sh $(1)/usr/libexec/rainbow/
endef

$(eval $(call BuildPackage,omnia-rainbow-backend))
