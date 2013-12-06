#
# Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris
PKG_VERSION:=12
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=ssh://git@git.nic.cz/router/foris
PKG_SOURCE_VERSION:=f85abbcba355601b90c7f7af1b34320e8b65d229
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/foris
	TITLE:=foris
	DEPENDS:=+python +python-bottle +python-bottle-i18n +python-beaker +python-flup +python-ncclient +nuci +lighttpd +lighttpd-mod-fastcgi +luci
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
/etc/config/foris
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
/etc/init.d/lighttpd enable
/etc/init.d/lighttpd restart
}
endef

define Package/foris/prerm
#!/bin/sh
set -x
/etc/init.d/lighttpd disable
/etc/init.d/lighttpd stop
endef

$(eval $(call BuildPackage,foris))
