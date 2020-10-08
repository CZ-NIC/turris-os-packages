#
## Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=follectd
PKG_VERSION:=5
PKG_RELEASE:=2

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/follectd
  SECTION:=web
  CATEGORY:=Web
  SUBMENU:=Foris Controller
  TITLE:=follectd
  DEPENDS:=\
    +collectd \
    +collectd-mod-cpu \
    +collectd-mod-disk \
    +collectd-mod-exec \
    +collectd-mod-interface \
    +collectd-mod-memory \
    +collectd-mod-unixsock
  USERID:=follectd=268:follectd=268
endef

define Package/follectd/description
  Instance of collectd server used as data source for foris-controller-collectd-module.
endef

Build/Compile:=:

define Package/follectd/conffiles
/etc/follectd.conf
endef

define Package/follectd/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/follectd.init $(1)/etc/init.d/follectd

	$(INSTALL_DIR) $(1)/usr/libexec/follectd/
	$(INSTALL_BIN) ./files/neighbours.sh $(1)/usr/libexec/follectd/neighbours.sh

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/follectd.conf $(1)/etc/follectd.conf
endef

define Package/follectd/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
	# run scripts to update files
	/etc/init.d/follectd enable
	/etc/init.d/follectd restart
}
endef

$(eval $(call BuildPackage,follectd))
