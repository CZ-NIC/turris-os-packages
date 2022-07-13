#
## Copyright (C) 2018-2021 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=start-indicator
PKG_VERSION:=1.0
PKG_RELEASE:=$(AUTORELEASE)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-2.0-or-later

include $(INCLUDE_DIR)/package.mk

define Package/start-indicator
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Start indicator
  DEPENDS:=+busybox
endef

define Package/start-indicator/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/start-indicator.init $(1)/etc/init.d/start-indicator
endef

Build/Compile:=

$(eval $(call BuildPackage,start-indicator))
