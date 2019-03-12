#
## Copyright (C) 2016 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=userlists
PKG_VERSION:=11.8
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/userlists
	TITLE:=Userlists for the updater
endef

define Build/Compile
	true
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/share/updater/
	$(INSTALL_DATA) ./files/definitions.json $(1)/usr/share/updater/definitions.json
endef

define Package/$(PKG_NAME)/postinst
[ -n "$$IPKG_INSTROOT" ] || {
	# Rename i_agree_honeypot to honeypot
	sed -i "s/list lists 'i_agree_honeypot'/list lists 'honeypot'/" /etc/config/updater
}
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
