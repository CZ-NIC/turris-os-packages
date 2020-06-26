#
## Copyright (C) 2014 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=smrt-image
PKG_VERSION:=1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/smrt-image.git
PKG_SOURCE_VERSION:=090fbdee94cff4e1396063a78d680aafe66904d7

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/smrt-image
	TITLE:=smrt-image
endef

Build/Compile:=:

define Package/smrt-image/install
	$(INSTALL_DIR) $(1)/usr/share/smrt/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/smrt.firmware $(1)/usr/share/smrt/firmware
endef

$(eval $(call BuildPackage,smrt-image))
