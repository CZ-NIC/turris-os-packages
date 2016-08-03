#
## Copyright (C) 2016 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=cznic-repo-keys
PKG_VERSION:=4
PKG_MAINTAINER:=Michal Hrusecky <michal.hrusecky@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+cert-backup
endef

define Package/$(PKG_NAME)-test
	TITLE:=$(PKG_NAME)
	DEPENDS:=+cert-backup
endef

# The built is empty. But as there's no makefile in the git repo, we need to
# override the default that runs "make".
define Build/Compile
	true
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/opkg/keys
	$(INSTALL_DIR) $(1)/etc/updater/keys/
	for i in release.pub standby.pub; do \
		$(CP) files/$$$$i $(1)/etc/opkg/keys/`$(STAGING_DIR_HOST)/bin/usign -F -p files/$$$$i`; \
		$(CP) files/$$$$i $(1)/etc/updater/keys; \
	done
endef

define Package/$(PKG_NAME)-test/install
	$(INSTALL_DIR) $(1)/etc/opkg/keys
	$(INSTALL_DIR) $(1)/etc/updater/keys/
	for i in test.pub; do \
		$(CP) files/$$$$i $(1)/etc/opkg/keys/`$(STAGING_DIR_HOST)/bin/usign -F -p files/$$$$i`; \
		$(CP) files/$$$$i $(1)/etc/updater/keys; \
	done
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
# TODO: To remove files, use -r
/usr/sbin/cert-backup /etc/updater/keys/release.pub /etc/updater/keys/standby.pub
}
endef

define Package/$(PKG_NAME)-test/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
# TODO: To remove files, use -r
/usr/sbin/cert-backup /etc/updater/keys/test.pub
}
endef

define Package/$(PKG_NAME)-test/postrm
#!/bin/sh
/usr/sbin/cert-backup -r /etc/updater/keys/test.pub
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_NAME)-test))
