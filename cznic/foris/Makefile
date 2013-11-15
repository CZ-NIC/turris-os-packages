#
# Copyright (C) 2013 CZ.NIC z.s.p.o. <jan.cermak@nic.cz>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris
PKG_VERSION:=1
PKG_RELEASE:=1
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=ssh://git@git.nic.cz/router/foris
PKG_SOURCE_VERSION:=283a92601d0a8da30090ad8108fb426666fb9880
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/foris
	TITLE:=foris
	DEPENDS:=+python +python-bottle +python-bottle-i18n +python-beaker +python-flup +python-ncclient +nuci +lighttpd +lighttpd-mod-fastcgi +luci +python-pbkdf2
	MAINTAINER:=Jan Cermak <jan.cermak@nic.cz>
endef

define Package/foris/description
	Web administration interface using nuci for communication.
endef

define Build/Compile
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS)
endef

FORIS_DIR=/www2

define Package/foris/conffiles
/etc/foris/foris-lighttpd-inc.conf
endef

define Package/foris/install
	$(INSTALL_DIR) $(1)/etc/foris
	$(INSTALL_DATA) ./files/foris-lighttpd-inc.conf $(1)/etc/foris/foris-lighttpd-inc.conf
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/foris $(1)/etc/config/foris
	$(INSTALL_DIR) $(1)$(FORIS_DIR)
	$(CP) $(PKG_BUILD_DIR)/config_handlers/ $(1)$(FORIS_DIR)/config_handlers/
	$(CP) $(PKG_BUILD_DIR)/locale/ $(1)$(FORIS_DIR)/locale/
	$(CP) $(PKG_BUILD_DIR)/nuci/ $(1)$(FORIS_DIR)/nuci/
	$(CP) $(PKG_BUILD_DIR)/templates/ $(1)$(FORIS_DIR)/templates/
	$(CP) $(PKG_BUILD_DIR)/utils/ $(1)$(FORIS_DIR)/utils/
	$(INSTALL_DIR) $(1)$(FORIS_DIR)/static/
	$(CP) $(PKG_BUILD_DIR)/static/{css,fonts,img,js} $(1)$(FORIS_DIR)/static/
	$(CP) $(PKG_BUILD_DIR)/*.py $(1)$(FORIS_DIR)/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/foris.py $(1)$(FORIS_DIR)/foris.py
endef

define Package/foris/postinst
#!/bin/sh
set -x
[ -n "$$IPKG_INSTROOT" ] || {
# save old uhttpd listen address to our config
old_listen_http=`uci get uhttpd.main.listen_http`
uci set foris.uhttpd=backup
uci set foris.uhttpd.old_listen_http=$$old_listen_http
host=`echo $$old_listen_http | sed -r "s/([^:]*):.*/\1/"`
# redirect uhttpd to port 8080
uci set uhttpd.main.listen_http=$$host:8080
uci commit
# TODO: port is related to lighttpd, not Foris...
/etc/init.d/uhttpd restart
/etc/init.d/lighttpd enable
/etc/init.d/lighttpd start
}
endef

define Package/foris/prerm
#!/bin/sh
set -x
# restore uhttpd listen address
old_listen_http=`uci get foris.uhttpd.old_listen_http`
uci set uhttpd.main.listen_http=$$old_listen_http
uci commit
/etc/init.d/lighttpd disable
/etc/init.d/lighttpd stop
/etc/init.d/uhttpd restart
endef

$(eval $(call BuildPackage,foris))
