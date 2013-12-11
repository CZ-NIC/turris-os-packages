#
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=canutils
PKG_VERSION:=4.0.6
PKG_RELEASE=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://www.pengutronix.de/software/socket-can/download/canutils/v4.0/
PKG_MD5SUM:=e9af32bc41da85517b7bfe7de3bb9481

include $(INCLUDE_DIR)/package.mk

FILES:= \
	canconfig candump canecho cansend cansequence

define PartGen
define Package/canutils-$(1)
  TITLE:=$(1) package from canutils
  SECTION:=utils
  CATEGORY:=Utilities
  DEPENDS:=canutils +libsocketcan
endef
endef

define Package/canutils
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=CAN userspace utilities and tools
  MENU:=1
endef

$(foreach file,$(FILES),$(eval $(call PartGen,$(file))))

define Package/canutils/install
	true
endef

define PartInstall
define Package/canutils-$(1)/install
	$(INSTALL_DIR) $$(1)/usr/bin
	$(INSTALL_BIN) \
		$(PKG_BUILD_DIR)/src/$(1) \
		$$(1)/usr/bin/
endef
endef

$(foreach file,$(FILES),$(eval $(call PartInstall,$(file))))

$(eval $(call BuildPackage,canutils))
$(foreach file,$(FILES),$(eval $(call BuildPackage,canutils-$(file))))
