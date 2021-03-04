#
## Copyright (C) 2020 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-motd
PKG_VERSION:=0.1.0
PKG_RELEASE:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/turris-motd
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Shells
  TITLE:=Turris Message of the day warning
endef

define Package/turris-motd/description
  Simple warning in "Message of the day" that Turris mail support covers only
  configuration done through reForis.
endef

define Package/turris-motd/install
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_DATA) ./files/motd $(1)/etc/motd
endef

define Package/turris-motd/conffiles
/etc/motd
endef

Build/Compile:=

$(eval $(call BuildPackage,turris-motd))
