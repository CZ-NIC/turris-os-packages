#
# Copyright (C) 2021 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=turris-auth
PKG_VERSION:=0.2.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/turris-auth.git
PKG_MIRROR_HASH:=e4252dfcac1f68d654df09837a62ec61731cd8cf6c1b78819ef9ccb86310141a
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=COPYING

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/turris-auth
  SECTION:=web
  CATEGORY:=Web
  TITLE:=Turris Authentication
  URL:=https://gitlab.nic.cz/turris/turris-auth
  DEPENDS:=\
    +lighttpd-mod-fastcgi \
    +python3-pbkdf2 \
    +python3-flup \
    +python3-jinja2 \
    +python3-uci
  VARIANT:=python3
endef

define Package/turris-auth/description
  Turris Authentication for web applications. This is login gateway that can be
  optionally added to any web application.
endef

define Py3Package/turris-auth/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc/lighttpd/conf.d
	$(INSTALL_CONF) ./files/lighttpd.conf $(1)/etc/lighttpd/conf.d/_turris-auth.conf
endef

define Package/turris-auth/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || /etc/init.d/lighttpd restart
endef

$(eval $(call Py3Package,turris-auth))
$(eval $(call BuildPackage,turris-auth))
$(eval $(call BuildPackage,turris-auth-src))
