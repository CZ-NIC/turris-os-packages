#
# Copyright (C) 2018-2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=luci-lighttpd
PKG_VERSION:=1
PKG_RELEASE:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/luci-lighttpd
  TITLE:=Support package of lighttpd for LuCI
  DEPENDS:=+luci-base +lighttpd-mod-cgi +lighttpd-mod-alias +lighttpd-mod-setenv
endef

Build/Compile:=:

define Package/luci-lighttpd/install
	$(INSTALL_DIR) $(1)/etc/lighttpd/conf.d/
	$(INSTALL_CONF) ./files/luci.conf $(1)/etc/lighttpd/conf.d/luci.conf
endef

define Package/luci-lighttpd/postinst
#!/bin/sh
if [ -z "$$IPKG_INSTROOT" ]; then
  /etc/init.d/lighttpd restart
fi
endef

define Package/luci-lighttpd/postrm
#!/bin/sh
if [ -z "$$IPKG_INSTROOT" ]; then
  /etc/init.d/lighttpd restart
fi
endef

$(eval $(call BuildPackage,luci-lighttpd))
