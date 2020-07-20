#
## Copyright (C) 2019 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=ltemetr-web
PKG_VERSION:=0.3
PKG_RELEASE:=1

PKG_SOURCE:=web-v$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://devpub.labs.nic.cz/ltemetr/
PKG_HASH:=e0abf8d1c958f4a63e50b0e7b5fddb1eafee54e01fedaee5970664ba3cbf2882

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-2.0-or-later

PKG_BUILD_DIR:=$(BUILD_DIR)/web-v$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/ltemetr-web
  TITLE:=Web interface for ltemetr
  URL:=https://gitlab.nic.cz/turris/ltemetr/web
  DEPENDS:=+ltemetr-core +lighttpd
endef

define Package/ltemetr-web/description
  Web interface for ltemetr.
endef

define Build/Compile
  true
endef

define Package/ltemetr-web/install
	$(INSTALL_DIR) $(1)/usr/share/turris-webapps
	$(INSTALL_CONF) ./files/09_ltemetr.conf $(1)/usr/share/turris-webapps/
	$(INSTALL_DIR) $(1)/www/webapps-icons
	$(INSTALL_DATA) ./files/ltemetr.png $(1)/www/webapps-icons/icon-ltemetr.png
	$(INSTALL_DIR) $(1)/etc/lighttpd/conf.d/
	$(INSTALL_CONF) ./files/ltemetr.lighttpd-conf $(1)/etc/lighttpd/conf.d/ltemetr.conf

	$(INSTALL_DIR)  $(1)/www/ltemetr
	$(CP) -r $(PKG_BUILD_DIR)/public $(1)/www/ltemetr
endef

define Package/ltemetr-web/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	/etc/init.d/lighttpd enable
	/etc/init.d/lighttpd restart
}
endef

define Package/ltemetr-web/prerm
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	rm -rf /www/ltemetr
}
endef

$(eval $(call BuildPackage,ltemetr-web))
