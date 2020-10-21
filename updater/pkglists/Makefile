#
## Copyright (C) 2016-2020 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=pkglists
PKG_VERSION:=1.5.4
PKG_RELEASE:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/pkglists
  SECTION:=updater
  CATEGORY:=Turris Updater
  TITLE:=Package lists for the updater
  DEPENDS:=+updater-ng +json4lua +libuci-lua
endef

define Package/pkglists/install
	$(INSTALL_DIR) $(1)/usr/share/updater/
	$(INSTALL_DATA) ./files/definitions.json $(1)/usr/share/updater/pkglists.json
	$(INSTALL_DATA) ./files/labels.json $(1)/usr/share/updater/pkglists-labels.json

	$(INSTALL_DIR) $(1)/etc/config $(1)/etc/updater/conf.d
	$(INSTALL_CONF) ./files/pkglists.uci $(1)/etc/config/pkglists
	$(INSTALL_DATA) ./files/updater.lua $(1)/etc/updater/conf.d/turris-pkglists.lua
endef

define Package/pkglists/conffiles
/etc/config/pkglists
endef

Build/Compile:=:

define Package/pkglists/postinst
if [ -n "$$IPKG_INSTROOT" ] &&  [ -n "$$BOOTSTRAP_PKGLISTS" ]; then
	mkdir -p "$$IPKG_INSTROOT/usr/share/updater"
	echo "$$BOOTSTRAP_PKGLISTS" \
		> "$$IPKG_INSTROOT/usr/share/updater/bootstrap-pkglists"
fi
endef

$(eval $(call BuildPackage,pkglists))
