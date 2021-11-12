#
## Copyright (C) 2021 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=turris1x-rainbow-backend
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/turris1x-rainbow-backend
  TITLE:=turris1x-rainbow-backend
  DEPENDS:=\
    @KERNEL_DEVMEM @TARGET_mpc85xx_p2020_DEVICE_turris1x \
    +turris1x-rainbow \
    +rainbow-button-sync \
    +rainbow-animator
  PROVIDES:=rainbow-backend
endef

Build/Compile:=:

define Package/turris1x-rainbow-backend/install
	$(INSTALL_DIR) $(1)/usr/share
	$(INSTALL_DATA) ./files/backend.sh $(1)/usr/libexec/rainbow/
	$(INSTALL_DATA) ./files/animator_backend.sh $(1)/usr/libexec/rainbow/
endef

$(eval $(call BuildPackage,turris1x-rainbow-backend))
