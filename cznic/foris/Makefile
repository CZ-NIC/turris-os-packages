#
# Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris
PKG_VERSION:=51
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/foris.git
PKG_SOURCE_VERSION:=950d34e0acc25e388b14cac90b1f5b89d116f890
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
PKG_BUILD_DEPENDS:=ruby/host python-slimit/host

include $(INCLUDE_DIR)/package.mk

define Package/foris
	TITLE:=foris
	DEPENDS:=+python +python-bottle +python-bottle-i18n +python-beaker +python-flup +python-ncclient +nuci +lighttpd +lighttpd-mod-fastcgi +luci +user_notify
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
/etc/lighttpd/conf.d/foris.conf
/etc/config/foris
endef

define Package/foris/install
	$(INSTALL_DIR) $(1)/etc/lighttpd/conf.d/
	$(INSTALL_DATA) ./files/foris.conf $(1)/etc/lighttpd/conf.d/foris.conf
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/foris $(1)/etc/config/foris
	$(INSTALL_DIR) $(1)$(FORIS_DIR)
	$(CP) $(PKG_BUILD_DIR)/config_handlers/ $(1)$(FORIS_DIR)/config_handlers/
	$(CP) $(PKG_BUILD_DIR)/locale/ $(1)$(FORIS_DIR)/locale/
	$(CP) $(PKG_BUILD_DIR)/nuci/ $(1)$(FORIS_DIR)/nuci/
	$(CP) $(PKG_BUILD_DIR)/templates/ $(1)$(FORIS_DIR)/templates/
	$(CP) $(PKG_BUILD_DIR)/utils/ $(1)$(FORIS_DIR)/utils/
	$(INSTALL_DIR) $(1)$(FORIS_DIR)/static/
	$(RM) $(PKG_BUILD_DIR)/static/js/{foris,foris.cs,parsley.foris-extend,parsley.messages.cs}.js
	$(CP) $(PKG_BUILD_DIR)/static/{css,img,js} $(1)$(FORIS_DIR)/static/
	$(CP) $(PKG_BUILD_DIR)/*.py $(1)$(FORIS_DIR)/
	$(CP) $(PKG_BUILD_DIR)/LICENSE $(1)$(FORIS_DIR)/LICENSE
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/foris.py $(1)$(FORIS_DIR)/foris.py
endef

define Package/foris/postinst
#!/bin/sh
set -x
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/lighttpd enable
/etc/init.d/lighttpd restart
# set wizard finished flag, can be removed after propagation
max_step=`uci get -q foris.wizard.allowed_step_max`
if [ "$$?" = 0 ]; then
	wizard_finished=`uci get -q foris.wizard.finished`
	if [ "$$?" = 1 ] && [ "$$max_step" -ge 8 ]; then
		uci set foris.wizard.finished=1
		uci commit
	fi
fi
}
endef

define Package/foris/prerm
#!/bin/sh
set -x
/etc/init.d/lighttpd disable
/etc/init.d/lighttpd stop
endef

define Package/foris-oldconfig
	TITLE:=foris old config
endef

define Package/foris-oldconfig/description
	A hack to go through installation from original Certuma image to something far newer without crashing the wizard step. Should not be needed during normal operation.
endef

define Package/foris-oldconfig/install
	$(INSTALL_DIR) $(1)/etc/foris
	$(INSTALL_DATA) ./files/foris.conf $(1)/etc/foris/foris-lighttpd-inc.conf
endef

$(eval $(call BuildPackage,foris))
$(eval $(call BuildPackage,foris-oldconfig))
