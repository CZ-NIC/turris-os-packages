#
## Copyright (C) 2019-2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=sentinel-i_agree_with_eula
PKG_VERSION:=1
PKG_RELEASE:=1
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/sentinel-i_agree_with_eula
  SECTION:=collect
  CATEGORY:=Collect
  SUBMENU:=Sentinel
  TITLE:=Package that accepts EULA
  DEPENDS:=+sentinel-proxy +sentinel-eula
endef

Build/Compile:=:

define Package/i_agree_with_eula/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	sed 's|@VERSION@|$(PKG_VERSION)|g'  ./files/i_agrre_with_eula > $(1)/etc/uci-defaults/10_i_agrre_with_eula
endef

define Package/sentinel-i_agree_with_eula/prerm
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
  if [ "$$(uci -q get sentinel.main.agreed_with_eula_version)" = $(PKG_VERSION) ]; then
    uci -q batch <<EOF
      delete sentinel.main.agreed_with_eula_version
      commit sentinel.main
    EOF
  fi
}
endef

$(eval $(call BuildPackage,sentinel-i_agree_with_eula))
