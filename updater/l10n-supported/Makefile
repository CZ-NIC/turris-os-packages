#
## Copyright (C) 2017-2020 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=l10n-supported
PKG_VERSION:=1.3
PKG_RELEASE:=4

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/l10n-supported
  SECTION:=updater
  CATEGORY:=Turris Updater
  TITLE:=List of localizations available in Turris repository
endef

Build/Compile:=:

define Package/l10n-supported/install
	$(INSTALL_DIR) $(1)/usr/share/updater/
	$(INSTALL_DATA) ./files/list $(1)/usr/share/updater/l10n_supported
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/uci-defaults $(1)/etc/uci-defaults/10-l10n-supported
endef

define Package/l10n-supported/postinst
if [ -n "$$IPKG_INSTROOT" ] && [ -n "$$BOOTSTRAP_L10N" ]; then
	mkdir -p "$$IPKG_INSTROOT/usr/share/updater"
	echo "$$BOOTSTRAP_L10N" \
		> "$$IPKG_INSTROOT/usr/share/updater/bootstrap-l10n"
fi
}
endef

$(eval $(call BuildPackage,l10n-supported))
