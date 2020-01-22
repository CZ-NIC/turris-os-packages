#
## Copyright (C) 2016-2020 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=pkglists
PKG_VERSION:=1.2.3
PKG_RELEASE:=2

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/pkglists
  SECTION:=updater
  CATEGORY:=Turris Updater
  TITLE:=Packages lists for the updater
endef

define Package/pkglists/install
	$(INSTALL_DIR) $(1)/usr/share/updater/
	$(INSTALL_DATA) ./files/definitions.json $(1)/usr/share/updater/pkglists.json
endef

Build/Compile:=:

$(eval $(call BuildPackage,pkglists))
