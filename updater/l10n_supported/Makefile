#
## Copyright (C) 2017 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=l10n_supported
PKG_VERSION:=1.3
PKG_RELEASE:=2
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/l10n_supported
	TITLE:=List of localizations available in Turris repository
endef

Build/Compile:=:

define Package/l10n_supported/install
	$(INSTALL_DIR) $(1)/usr/share/updater/
	$(INSTALL_DATA) ./files/list $(1)/usr/share/updater/l10n_supported
endef

define Package/l10n_supported/postinst
#!/bin/sh
# When there is no l10n section then add it.
if [ -z "$${IPKG_INSTROOT}" ] && ! uci -q get updater.l10n; then
	uci set updater.l10n=l10n
	uci add_list updater.l10n.langs=cs
	uci add_list updater.l10n.langs=de
	LANG="$$(uci get foris.settings.lang)" && [ "$$LANG" != en ] && \
		 uci add_list updater.l10n.langs=$$LANG
	uci commit updater
fi
endef

$(eval $(call BuildPackage,l10n_supported))
