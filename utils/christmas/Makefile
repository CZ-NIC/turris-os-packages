#
## Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=christmas
PKG_VERSION:=0.3
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/christmas.git
PKG_MIRROR_HASH:=36f08ce84f3c8c54ab30a5cb02eba6acedc59c6b0a1c5f8d6a677d2052a1a2e8
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE.md

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/christmas
  TITLE:=Christmas
  URL:=https://gitlab.nic.cz/turris/christmas
  DEPENDS:=+python3-light +python3-uci
  DEPENDS+=@(TARGET_mvebu_cortexa9_DEVICE_cznic_turris-omnia||TARGET_mpc85xx_p2020_DEVICE_turris1x)
  VARIANT:=python3
endef

define Package/christmas/description
  Shine Turris router like a Christmas tree
endef

define Package/christmas/conffiles
/etc/config/christmas
endef

define Py3Package/christmas/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/christmas.init $(1)/etc/init.d/christmas

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/files/christmas.uci $(1)/etc/config/christmas
endef

$(eval $(call Py3Package,christmas))
$(eval $(call BuildPackage,christmas))
$(eval $(call BuildPackage,christmas-src))
