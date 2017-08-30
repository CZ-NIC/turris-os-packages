#
## Copyright (C) 2017 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=server-uplink
PKG_VERSION:=1
PKG_MAINTAINER:=Stepan Henek <stepan.henek@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+curl +cznic-cacert-bundle
endef

define Package/$(PKG_NAME)/description
 Contains a couple of scripts which are resposible to communicate with server realated to
 Turris Project.
endef

# The built is empty. But as there's no makefile in the git repo, we need to
# override the default that runs "make".
define Build/Compile
	true
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/cron.d
	$(INSTALL_DATA) files/server-uplink.cron $(1)/etc/cron.d/

	$(INSTALL_DIR) $(1)/usr/share/server-uplink/
	$(INSTALL_BIN) files/registration_code.sh $(1)/usr/share/server-uplink/
	$(INSTALL_BIN) files/contract_valid.sh $(1)/usr/share/server-uplink/
	$(INSTALL_BIN) files/registered.sh $(1)/usr/share/server-uplink/
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
	# run scripts to update files
	/usr/share/server-uplink/registration_code.sh
	/usr/share/server-uplink/contract_valid.sh
}
endef

define Package/$(PKG_NAME)/postrm
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
	# remove downloaded files
	rm -rf /usr/share/server-uplink
}
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
