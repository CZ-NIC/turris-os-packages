#
## Copyright (C) 2019-2020 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=updater-supervisor
PKG_VERSION:=1.4.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/updater/supervisor.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=MIT

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/updater-supervisor
  SECTION:=updater
  CATEGORY:=Turris Updater
  TITLE:=Updater supervisor and its library
  DEPENDS:= \
    +updater-ng +pkglists +l10n-supported \
    +python3-light +python3-uci +python3-distro \
    +cronie
  VARIANT:=python3
endef

define Py3Package/updater-supervisor/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/immediate_reboot.init $(1)/etc/init.d/updater-journal-recover
	$(INSTALL_DIR) $(1)/etc/cron.d
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/files/cron $(1)/etc/cron.d/updater
	$(INSTALL_DIR) $(1)/etc/updater/hook_postupdate
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/hook_postupdate $(1)/etc/updater/hook_postupdate/99_approvals_cleanup
endef

$(eval $(call Py3Package,updater-supervisor))
$(eval $(call BuildPackage,updater-supervisor))
$(eval $(call BuildPackage,updater-supervisor-src))
