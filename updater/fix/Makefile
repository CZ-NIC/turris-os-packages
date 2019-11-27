#
## Copyright (C) 2019 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=fix
PKG_VERSION:=1
PKG_RELEASE:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

Build/Compile:=:

define FIX

define Package/fix-$(1)
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Fixes
  TITLE:=$(1)
  DEPENDS:=$(2)
endef

define Package/fix-$(1)/install
	$(INSTALL_DIR) $$(1)/usr/libexec/fix
	$(INSTALL_BIN) ./files/$(1) $$(1)/usr/libexec/fix/$(1)
endef

define Package/fix-$(1)/postinst
/usr/libexec/fix/$(1)
endef

$$(eval $$(call BuildPackage,fix-$(1)))

endef

define Package/fix-pkglists-options/description
  Migrate pkglists from /etc/config/updater to separate pkglists configuration
  file and set all appropriate options for pkglists.
  This is installed if pkglists version is older than 1.3.
endef

$(eval $(call FIX,pkglists-options,pkglists))
