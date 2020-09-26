#
## Copyright (C) 2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=logc
PKG_VERSION:=0.1.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/logc.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_DEPENDS:=argp-standalone gperf/host

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/autotools.mk

define Package/logc/Default
  SECTION:=libs
  CATEGORY:=Libraries
  URL:=https://gitlab.nic.cz/turris/logc.git
endef

define Package/logc
  $(call Package/logc/Default)
  TITLE:=logc
endef

define Package/logc-argp
  $(call Package/logc/Default)
  TITLE:=logc-argp
endef

define Package/logc/description
  Logging library for C (LogC)
endef

define Package/logc-argp/description
  Argument parsing library for LogC base on argp.
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/* $(1)/usr/include/

	$(INSTALL_DIR) $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/* $(1)/usr/lib/
endef

define Package/logc/install
	$(INSTALL_DIR) $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/liblogc.so* $(1)/usr/lib/
endef

define Package/logc-argp/install
	$(INSTALL_DIR) $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/liblogc_argp.so* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,logc))
$(eval $(call BuildPackage,logc-argp))
