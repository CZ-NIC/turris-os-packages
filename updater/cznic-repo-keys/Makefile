#
## Copyright (C) 2016-2022 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=cznic-repo-keys
PKG_VERSION:=4.2
PKG_RELEASE:=$(AUTORELEASE)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

PKG_BUILD_DEPENDS:=usign/host

include $(INCLUDE_DIR)/package.mk

define Package/cznic-repo-keys
	TITLE:=CZNIC repo keys
	DEPENDS:=+cert-backup
endef

define Package/cznic-repo-keys-test
	TITLE:=CZNIC repo keys test
	DEPENDS:=+cert-backup
endef

Build/Compile:=:

define Package/cznic-repo-keys/install
	$(INSTALL_DIR) $(1)/etc/opkg/keys
	$(INSTALL_DIR) $(1)/etc/updater/keys/
	for i in release standby; do \
		USIGNNAME="$$$$($(STAGING_DIR_HOST)/bin/usign -F -p files/$$$$i.pub)"; \
		$(CP) files/$$$$i.pub $(1)/etc/opkg/keys/$$$$USIGNNAME; \
		$(CP) files/$$$$i.pub $(1)/etc/updater/keys/; \
		$(CP) files/$$$$i.pub.sig $(1)/etc/updater/keys/; \
	done
endef

define Package/cznic-repo-keys-test/install
	$(INSTALL_DIR) $(1)/etc/opkg/keys
	$(INSTALL_DIR) $(1)/etc/updater/keys/
	for i in test; do \
		USIGNNAME="$$$$($(STAGING_DIR_HOST)/bin/usign -F -p files/$$$$i.pub)"; \
		$(CP) files/$$$$i.pub $(1)/etc/opkg/keys/$$$$USIGNNAME; \
		$(CP) files/$$$$i.pub $(1)/etc/updater/keys/; \
		$(CP) files/$$$$i.pub.sig $(1)/etc/updater/keys/; \
	done
endef

define Package/cznic-repo-keys/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
# NOTE: To remove files, use -r
/usr/sbin/cert-backup /etc/updater/keys/release.pub /etc/updater/keys/standby.pub
}
endef

define Package/cznic-repo-keys-test/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
# NOTE: To remove files, use -r
/usr/sbin/cert-backup /etc/updater/keys/test.pub
}
endef

define Package/cznic-repo-keys-test/postrm
#!/bin/sh
/usr/sbin/cert-backup -r /etc/updater/keys/test.pub
endef

$(eval $(call BuildPackage,cznic-repo-keys))
$(eval $(call BuildPackage,cznic-repo-keys-test))
