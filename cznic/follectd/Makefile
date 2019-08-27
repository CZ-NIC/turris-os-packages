#
## Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=follectd
PKG_VERSION:=2
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=\
		+collectd \
		+collectd-mod-cpu \
		+collectd-mod-disk \
		+collectd-mod-exec \
		+collectd-mod-interface \
		+collectd-mod-memory \
		+collectd-mod-unixsock \

	USERID:=follect=268:follect=268
endef

define Package/$(PKG_NAME)/description
	Instance of collectd server used as data source for foris-controller-collectd-module
endef

# The built is empty. But as there's no makefile in the git repo, we need to
# override the default that runs "make".
define Build/Compile
	true
endef

define Package/$(PKG_NAME)/conffiles
/etc/follectd.conf
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/follectd.init $(1)/etc/init.d/follectd

	$(INSTALL_DIR) $(1)/usr/libexec/follect/
	$(INSTALL_BIN) ./files/neighbours.sh $(1)/usr/libexec/follect/neighbours.sh

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/follectd.conf $(1)/etc/follectd.conf
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
	# run scripts to update files
	/etc/init.d/follectd enable
	/etc/init.d/follectd restart
}
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
