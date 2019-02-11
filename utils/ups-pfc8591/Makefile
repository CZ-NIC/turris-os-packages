#
# Copyright (C) 2017 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ups-pfc8591
PKG_VERSION:=v0.2
PKG_RELEASE:=1
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENCE.txt

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://git.cynerd.cz/turris-ups-pfc8591
PKG_SOURCE_VERSION:=$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/ups-pfc8591
  TITLE:=ups-pfc8591
  URL:=https://git.cynerd.cz/turris-i2c-collect
  DEPENDS:=+python +python-perifery +ubus +python-sqlite3
endef

define Package/foris-plugin-ups-pfc8591
  TITLE:=foris-plugin-ups-pfc8591
  URL:=http://git.cynerd.cz/turris-i2c-collect
  DEPENDS:=+python +foris +ups-pfc8591
endef

define Build/Compile
	true
endef

define Package/ups-pfc8591/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/daemon.py $(1)/usr/bin/ups-pfc8591-daemon
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/init $(1)/etc/init.d/ups-pfc8591
endef

define Package/foris-plugin-ups-pfc8591/install
	$(INSTALL_DIR) $(1)/usr/share/foris/plugins
	cp -a $(PKG_BUILD_DIR)/foris $(1)/usr/share/foris/plugins/ups-pfc8591
endef

define Package/ups-pfc8591/postinst
	[ -n "$$IPKG_INSTROOT" ] || {
		/etc/init.d/ups-pfc8591 enable
		/etc/init.d/ups-pfc8591 restart
	}
endef

define Package/ups-pfc8591/prerm
	[ -n "$$IPKG_INSTROOT" ] || {
		/etc/init.d/ups-pfc8591 stop
		/etc/init.d/ups-pfc8591 disable
	}
endef

define Package/foris-plugin-ups-pfc8591/postinst
	[ -n "$$IPKG_INSTROOT" ] || {
		/etc/init.d/lighttpd restart
	}
endef

$(eval $(call BuildPackage,ups-pfc8591))
$(eval $(call BuildPackage,foris-plugin-ups-pfc8591))
