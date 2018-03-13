#
## Copyright (C) 2018 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=lighttpd-luci
PKG_VERSION:=1
PKG_MAINTAINER:=CZ.NIC <packaging@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+lighttpd-mod-alias +lighttpd-mod-cgi +lighttpd-mod-setenv +luci-base
endef

define Build/Compile
	true
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/lighttpd/conf.d/
	$(INSTALL_CONF) ./files/luci.conf $(1)/etc/lighttpd/conf.d/luci.conf
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
if [ -z "$$IPKG_INSTROOT" ]; then
  /etc/init.d/lighttpd restart
fi
endef

define Package/$(PKG_NAME)/postrm
#!/bin/sh
/etc/init.d/lighttpd restart
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
