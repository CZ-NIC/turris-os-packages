#
## Copyright (C) 2018 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-cagen
PKG_VERSION:=3
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+openssl-util
endef

define Package/$(PKG_NAME)/description
  A simple program which should be capeable to generate CAs, certificates, dhparams, ...
endef

# The built is empty. But as there's no makefile in the git repo, we need to
# override the default that runs "make".
define Build/Compile
	true
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/cagen
	$(INSTALL_CONF) files/openssl.cnf $(1)/etc/cagen/

	$(INSTALL_DIR) $(1)/etc/cron.d
	$(INSTALL_DATA) files/cagen.cron $(1)/etc/cron.d/turris-cagen

	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) files/cagen.sh $(1)/usr/bin/turris-cagen
	$(INSTALL_BIN) files/cagen-status.sh $(1)/usr/bin/turris-cagen-status
endef


$(eval $(call BuildPackage,$(PKG_NAME)))
