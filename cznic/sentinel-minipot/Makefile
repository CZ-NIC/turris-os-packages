#
## Copyright (C) 2018 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=sentinel-minipot
PKG_VERSION:=1
PKG_RELEASE:=6
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/sentinel/minipot.git
PKG_SOURCE_VERSION:=ebc6c8f96202b6c122fcc8f94b9413ec6bfd2e4f
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Martin Petracek <martin.petracek@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+czmq +libevent2 +msgpack-c +sentinel-proxy
endef

define Build/Compile
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS)
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/sentinel_minipot $(1)/usr/bin/sentinel-minipot
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/init $(1)/etc/init.d/sentinel-minipot
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_BIN) ./files/config $(1)/etc/config/sentinel
	$(INSTALL_DIR) $(1)/etc/firewall.d
	$(INSTALL_DIR) $(1)/etc/firewall.d/with_reload
	$(INSTALL_BIN) ./files/fw_reload $(1)/etc/firewall.d/with_reload/99_sentinel_minipot.fw
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/sentinel-minipot enable
/etc/init.d/sentinel-minipot restart
}
endef

define Package/$(PKG_NAME)/prerm
#!/bin/sh
/etc/init.d/sentinel-minipot disable
/etc/init.d/sentinel-minipot stop
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
