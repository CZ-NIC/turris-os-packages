#
## Copyright (C) 2018-2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=server-uplink
PKG_VERSION:=6
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  TITLE:=$(PKG_NAME)
  DEPENDS:=+libatsh204 +curl +cznic-cacert-bundle
endef

define Package/server-nouplink
  TITLE:=$(PKG_NAME)
  PROVIDES:=$(PKG_NAME)
  CONFLICTS:=$(PKG_NAME)
endef

define Package/$(PKG_NAME)/description
 Contains a couple of scripts which are resposible to communicate with server realated to
 Turris Project.
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/cron.d
	$(INSTALL_DATA) files/server-uplink.cron $(1)/etc/cron.d/

	$(INSTALL_DIR) $(1)/usr/share/server-uplink/
	$(INSTALL_BIN) files/registration_code.sh $(1)/usr/share/server-uplink/
	$(INSTALL_BIN) files/registered.sh $(1)/usr/share/server-uplink/
endef

define Package/server-nouplink/install
	$(INSTALL_DIR) $(1)/usr/share/server-uplink/
	$(INSTALL_BIN) files/fake/registration_code.sh $(1)/usr/share/server-uplink/
	$(INSTALL_BIN) files/fake/registered.sh $(1)/usr/share/server-uplink/
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
	# run script to update files
	/usr/share/server-uplink/registration_code.sh
}
endef

define Package/$(PKG_NAME)/postrm
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
	# remove downloaded files
	rm -rf /usr/share/server-uplink
}
endef

Build/Compile:=:

$(eval $(call BuildPackage,$(PKG_NAME)))
$(eval $(call BuildPackage,server-nouplink))
