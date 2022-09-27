#
## Copyright (C) 2018-2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-utils
PKG_VERSION:=2.1
PKG_RELEASE:=$(AUTORELEASE)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/turris-utils
	TITLE:=Turris utils
endef

define Package/turris-utils/install
	$(INSTALL_DIR) $(1)/sbin
	$(INSTALL_BIN) ./files/check_connection $(1)/sbin/check_connection
endef

Build/Compile:=:

$(eval $(call BuildPackage,turris-utils))
