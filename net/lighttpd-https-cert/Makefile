#
## Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=lighttpd-https-cert
PKG_VERSION:=6
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+lighttpd-mod-openssl
endef

define Build/Compile
	true
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/lighttpd/conf.d/
	$(INSTALL_CONF) ./files/ssl-enable.conf $(1)/etc/lighttpd/conf.d/ssl-enable.conf.example
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/lighttpd-https-cert.init $(1)/etc/init.d/lighttpd-https-cert
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
if [ -z "$$IPKG_INSTROOT" ]; then
	/etc/init.d/lighttpd-https-cert enable
	/etc/init.d/lighttpd-https-cert start
else
    {
    echo '#!/bin/sh'
	echo '/etc/init.d/lighttpd-https-cert enable'
	echo '/etc/init.d/lighttpd-https-cert start'
    } > "$$IPKG_INSTROOT"/etc/uci-defaults/https-cert
  fi
fi
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
