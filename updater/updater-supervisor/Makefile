#
## Copyright (C) 2019-2022 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=updater-supervisor
PKG_VERSION:=1.5.3
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/updater/supervisor.git
PKG_MIRROR_HASH:=232ddf02231e34a87970441dde6d9ec4d11aee4f66a788808389cb80f5707d5c
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
    +python3-light +python3-uci +python3-distro +python3-packaging +python3-crontab \
    +cronie
  VARIANT:=python3
endef

define Package/updater-supervisor/description
  Python library and program wrapping execution of updater-ng's pkgupdate tool. It
  integrates it to frontend and provides additional reporting mechanisms.
  Secondary this also serves as universal configuration API for updater-ng.
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
