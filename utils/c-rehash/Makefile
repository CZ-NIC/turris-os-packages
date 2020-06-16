#
## Copyright (C) 2015-2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=c-rehash
PKG_VERSION:=1.7
PKG_RELEASE:=3

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/c-rehash
  TITLE:=c-rehash
  DEPENDS:=+openssl-util
endef

Build/Compile:=:

define Package/c-rehash/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/openssl-c_rehash.sh $(1)/usr/bin/c_rehash
endef

$(eval $(call BuildPackage,c-rehash))
