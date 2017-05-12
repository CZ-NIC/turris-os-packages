#
## Copyright (C) 2017 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=l10n_supported
PKG_VERSION:=1.1
PKG_RELEASE:=3
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
PKG_BUILD_DEPENDS:=uci/host

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=List of localizations available in Turris repository
	DEPENDS:=+uci +updater-ng
endef

define Build/Compile
	true
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/share/updater/
	$(INSTALL_DATA) ./files/list $(1)/usr/share/updater/l10n_supported
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
# When there is no l10n section then add it.
UCIC="uci -c $${IPK_INSTROOT}/etc/config"
if ! uci -q get updater.l10n; then
	$$UCIC set updater.l10n=l10n
	$$UCIC add_list updater.l10n.langs=cs
	$$UCIC add_list updater.l10n.langs=de
	$$UCIC commit updater
fi
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
