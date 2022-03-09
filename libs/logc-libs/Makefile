#
## Copyright (C) 2021 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=logc-libs
PKG_VERSION:=0.1.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/logc-libs.git
PKG_MIRROR_HASH:=f89cda404e12e927c01facf094a22c7a47298c7dfc4a9cf16d9122f6904bbcf4
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/autotools.mk

define Package/logc-libs/Default
  SECTION:=libs
  CATEGORY:=Libraries
  URL:=https://gitlab.nic.cz/turris/logc-libs
endef

define Package/logc-czmq
  $(call Package/logc-libs/Default)
  DEPENDS:=+logc +czmq
  TITLE:=logc-czmq
endef

define Package/logc-libevent
  $(call Package/logc-libs/Default)
  DEPENDS:=+logc +libevent2
  TITLE:=logc-libevent
endef

define Package/logc-czmq/description
  Logging library for C - CZMQ plugin
endef

define Package/logc-libevent/description
  Logging library for C - libevent plugin
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/* $(1)/usr/include/

	$(INSTALL_DIR) $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/* $(1)/usr/lib/
endef

define Package/logc-czmq/install
	$(INSTALL_DIR) $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libczmq_logc.so* $(1)/usr/lib/
endef

define Package/logc-libevent/install
	$(INSTALL_DIR) $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libevent_logc.so* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,logc-czmq))
$(eval $(call BuildPackage,logc-libevent))
