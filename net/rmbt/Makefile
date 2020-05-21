#
## Copyright (C) 2016-2017 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=rmbt-client
PKG_VERSION:=1.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/lwimmer/rmbt-client/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=1dd86cb88fd171b6a229c353384dc5f77a70411fcd7f13979cb24a084a467c62

PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=RMBT speed measurement client in C
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
	DEPENDS:=+libuuid +libopenssl +libjson-c +liblzma +librt
endef
define Package/$(PKG_NAME)/description
  Desc
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/rmbt $(1)/usr/bin/rmbt
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
