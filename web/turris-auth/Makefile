#
# Copyright (C) 2021-2022 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=turris-auth
PKG_VERSION:=0.4.0
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/turris-auth.git
PKG_MIRROR_HASH:=946614b3734ecf567cc8a72f1942c1fe9ec44598f125a7757ac3643383748e4a
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=COPYING

HOST_PYTHON3_PACKAGE_BUILD_DEPENDS:=MarkupSafe

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/turris-auth
  SECTION:=web
  CATEGORY:=Web
  TITLE:=Turris Authentication
  URL:=https://gitlab.nic.cz/turris/turris-auth
  DEPENDS:=\
    +lighttpd-mod-fastcgi \
    +lighttpd-mod-alias \
    +turris-bootstrap-theme \
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
