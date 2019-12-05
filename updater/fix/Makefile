#
## Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
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
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

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


define Package/fix-sentinel-remove-invalid-firewall-rules/description
  This is used to remove data collection firewall rules before we update those
  packages. Initial requirement was because originaly those rules were not fully
  inserted and so they were invalid. Although this can be reused later.
endef

$(eval $(call FIX,sentinel-remove-invalid-firewall-rules,+firewall +uci))
