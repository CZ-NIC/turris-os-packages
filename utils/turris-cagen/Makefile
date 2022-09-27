#
## Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-cagen
PKG_VERSION:=6
PKG_RELEASE:=$(AUTORELEASE)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/turris-cagen
  TITLE:=turris-cagen
  DEPENDS:=+openssl-util
endef

define Package/$(PKG_NAME)/description
  A simple program which should be capeable to generate CAs, certificates, dhparams, ...
endef

Build/Compile:=:

define Package/turris-cagen/install
	$(INSTALL_DIR) $(1)/etc/cagen
	$(INSTALL_CONF) files/openssl.cnf $(1)/etc/cagen/

	$(INSTALL_DIR) $(1)/etc/cron.d
	$(INSTALL_DATA) files/cagen.cron $(1)/etc/cron.d/turris-cagen

	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) files/cagen.sh $(1)/usr/bin/turris-cagen
	$(INSTALL_BIN) files/cagen-status.sh $(1)/usr/bin/turris-cagen-status

	$(INSTALL_DIR) $(1)/usr/share/turris-cagen/
	$(INSTALL_DATA) files/dhparam.pem $(1)/usr/share/turris-cagen/dhparam.pem
endef


$(eval $(call BuildPackage,turris-cagen))
