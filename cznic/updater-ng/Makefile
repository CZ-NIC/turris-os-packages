#
## Copyright (C) 2016-2017 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=updater-ng
PKG_VERSION:=60.4.3
PKG_RELEASE:=1
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/updater.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
HOST_BUILD_DIR:=$(BUILD_DIR_HOST)/$(PKG_NAME)
HOST_BUILD_DEPENDS:=curl/host libevent2/host lua/host
PKG_BUILD_DEPENDS:=busybox

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk
$(call include_mk, python-package.mk)
$(call include_mk, python3-package.mk)

define Package/$(PKG_NAME)
	TITLE:=The next generation updater
	DEPENDS:=+liblua +libuci-lua +libevent2 +usign +libcurl +ca-certificates
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lib/libupdater.so $(1)/usr/lib/

	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/opkg-trans $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/pkgupdate $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/supervisor/updater.sh $(1)/usr/bin/
	$(INSTALL_BIN) .//files/updater-wipe.sh $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/updater
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/src/pkgupdate/configs/conf.lua $(1)/etc/updater
	$(INSTALL_DIR) $(1)/etc/updater/conf.d
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/src/pkgupdate/configs/base.lua $(1)/etc/updater/conf.d/base.lua
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/src/pkgupdate/configs/example.lua $(1)/etc/updater/conf.d/example.lua

	$(INSTALL_DIR) $(1)/etc/updater/hook_preupdate
	$(INSTALL_DIR) $(1)/etc/updater/hook_postupdate
	$(INSTALL_DIR) $(1)/etc/updater/hook_reboot_required
	touch $(1)/etc/updater/hook_preupdate/.keep
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/pkgupdate/hook_postupdate/update_alternatives.sh $(1)/etc/updater/hook_postupdate/update_alternatives.sh
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/pkgupdate/hook_reboot_required/50-create-notification.sh $(1)/etc/updater/hook_reboot_required/50-create-notification.sh

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/updater.config $(1)/etc/config/updater
ifneq ($(PKG_BRANCH),)
	echo >> $(1)/etc/config/updater
	echo "config override 'override'" >> $(1)/etc/config/updater
	echo "	option branch '$(PKG_BRANCH)'" >> $(1)/etc/config/updater
endif

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/pkgupdate/init $(1)/etc/init.d/updater
endef

define Package/$(PKG_NAME)/conffiles
/etc/updater/conf.d/example.lua
/etc/config/updater
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
if [ -z "$$IPKG_INSTROOT" ]; then
	/etc/init.d/updater enable || true
fi

# Remove morphered syntax from auto.lua
# This matches all Install and Package commands not followed by brackets. Whole
# line is enclosed with brackets and between strings and tables are added commas.
# Note: we don't have to check opkg-auto.lua as we do this migration before we
# move auto.lua to that name.
if [ -f "$$IPKG_INSTROOT/etc/updater/auto.lua" ]; then
	AUTOTMP="$$(mktemp)"
	sed -E '/^(Install|Package) +[^(]/{
			s/(Install|Package) +(.*)/\1(\2)/;
			s/("|\}) ("|\{)/\1, \2/g
		}' "$$IPKG_INSTROOT/etc/updater/auto.lua" > "$$AUTOTMP"
	# Note: Edit in place in busybox limits regexp syntax so we are using our temporally file
	mv "$$AUTOTMP" "$$IPKG_INSTROOT/etc/updater/auto.lua"
fi

# With updater version 60.0 all configurations were moved to /etc/updater/conf.d/
conf_move() {
	if [ -f "$$IPKG_INSTROOT/etc/updater/$$1" -a ! -f "$$IPKG_INSTROOT/etc/updater/conf.d/$$2" ]; then
		mv "$$IPKG_INSTROOT/etc/updater/$$1" "$$IPKG_INSTROOT/etc/updater/conf.d/$$2"
	fi
}
conf_move user.lua user.lua
conf_move auto.lua opkg-auto.lua
endef

define Build/Compile
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS) NO_DOC=1 LUA_COMPILE:=no UPDATER_VERSION:=$(PKG_VERSION) BUSYBOX_EXEC=$(STAGING_DIR)/bin/busybox-static
	$(call Build/Compile/PyMod,src/supervisor,install --prefix="/usr" --root=$(PKG_INSTALL_DIR)/py2)
	$(call Build/Compile/Py3Mod,src/supervisor,install --prefix="/usr" --root=$(PKG_INSTALL_DIR)/py3)
endef

define Host/Compile
	$(MAKE) $(HOST_JOBS) -C $(HOST_BUILD_DIR) $(HOST_MAKE_FLAGS) NO_DOC=1 LUA_COMPILE:=no UPDATER_VERSION:=$(PKG_VERSION)
endef

define Host/Install
	$(INSTALL_DIR) $(STAGING_DIR_HOST)/usr/lib/
	$(INSTALL_BIN) $(HOST_BUILD_DIR)/lib/libupdater.so $(STAGING_DIR_HOST)/usr/lib/

	$(INSTALL_DIR) $(STAGING_DIR_HOST)/usr/bin
	$(INSTALL_BIN) $(HOST_BUILD_DIR)/bin/opkg-trans $(STAGING_DIR_HOST)/usr/bin/
	$(INSTALL_BIN) $(HOST_BUILD_DIR)/bin/pkgupdate $(STAGING_DIR_HOST)/usr/bin/
endef


define Package/$(PKG_NAME)-supervisor
	TITLE:=Next generation updater supervisor
	DEPENDS:=+updater-ng-py3-supervisor +updater-ng +vixie-cron
endef

define Package/$(PKG_NAME)-supervisor/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/supervisor/updater-supervisor $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/cron.d
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/src/supervisor/cron $(1)/etc/cron.d/updater

	$(INSTALL_DIR) $(1)/etc/updater/hook_postupdate
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/supervisor/hook_postupdate $(1)/etc/updater/hook_postupdate/99_approvals_cleanup
endef


define Package/$(PKG_NAME)-py2-supervisor
	TITLE:=Next generation updater supervisor Python 2 library
	DEPENDS:=+updater-ng +python-light +python-uci +userlists +l10n_supported
	EXTRA_DEPENDS:=userlists (>=11)
endef


define Package/$(PKG_NAME)-py3-supervisor
	TITLE:=Next generation updater supervisor Python 3 library
	DEPENDS:=+updater-ng +python3-light +python3-uci +userlists +l10n_supported
	EXTRA_DEPENDS:=userlists (>=11)
endef


define Package/$(PKG_NAME)-localrepo
	TITLE:=Next generation updater local repository manager
	DEPENDS:=+python-light
endef

define Package/$(PKG_NAME)-localrepo/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/localrepo/localrepo $(1)/usr/bin/localrepo
	$(INSTALL_DIR) $(1)/etc/updater/conf.d
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/src/localrepo/localrepo.lua $(1)/etc/updater/conf.d/localrepo.lua
endef

# Repository should be consistent when updater is executed successfully but this
# ensures that we will fix any problems that can be caused by older version of
# localrepo
define Package/$(PKG_NAME)-localrepo/postinst
[ -n "$$IPKG_INSTROOT" ] || {
	localrepo check --fix
}
endef


define Package/$(PKG_NAME)-opkg
	TITLE:=OPKG compatibility wrapper for next generation updater
	DEPENDS:=+opkg +$(PKG_NAME)-localrepo
endef

define Package/$(PKG_NAME)-opkg/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/opkg-wrapper/opkg $(1)/usr/bin/opkg-pkgupdate-wrapper.sh
	$(INSTALL_DIR) $(1)/usr/share/updater
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/localrepo/content2localrepo $(1)/usr/share/updater/opkg-content2localrepo.sh
	$(INSTALL_DIR) $(1)/etc/updater/conf.d
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/src/opkg-wrapper/opkg.lua $(1)/etc/updater/conf.d/opkg.lua
endef

# We are calling migration to localrepo from updater-ng-opkg package posinst as
# this one is called after updater-ng-localrepo one and script expect both of
# these packages.
define Package/$(PKG_NAME)-opkg/postinst
[ -n "$$IPKG_INSTROOT" ] || {
	/usr/share/updater/opkg-content2localrepo.sh
}
endef

# Current implementation of updater can't remove package before replan and so we
# can't let updater-ng steal opkg-trans files. With dependency:
#   if not version_match then
# 		Package 'updater-ng' { deps = 'opkg-trans' }
# 	end
# this empty package should ensure that we correctly move packages from opkg-trans
# to updater-ng even with old version of updater. Unfortunately this won't work
# with downgrade.
# Note that because version_match was defined after package rename we can't use it
# to check version. But if it isn't defined than we know that we are using some
# old version of updater.
define Package/opkg-trans
	TITLE:=Dummy opkg-trans package
endef

define Package/opkg-trans/install
	true
endef

# This is same case as opkg-trans. Updater is package with originally obsolete
# updater version.
define Package/updater
	TITLE:=Dummy updater package
endef

define Package/updater/install
	true
endef

# We are migrating away from Nuci for Foris. But during this migration there is
# a problem where updater update it self and then requests approval. But because
# we dropped some files nuci expects and Foris is not yet updated there is no way
# user can easily approve update. Solution is to have package providing those
# missing file and install it temporally just to fix that problem.
define Package/$(PKG_NAME)-migration-helper
	TITLE:=Package for smoot migration of updater-ng
endef

define Package/$(PKG_NAME)-migration-helper/install
	$(INSTALL_DIR) $(1)/usr/bin	
	echo '#!/bin/sh' > $(1)/usr/bin/updater-unstuck.sh
	chmod +x $(1)/usr/bin/updater-unstuck.sh
endef
# updater-wipe.sh is temporally in updater-ng package for Foris Wizard
# compatibility. We should drop it from updater-ng when wizard is dropped and
# return it to this package.
#	echo '#!/bin/sh' > $(1)/usr/bin/updater-wipe.sh
#	chmod +x $(1)/usr/bin/updater-wipe.sh


PKG_INSTALL_DIR_ORIG:="$(PKG_INSTALL_DIR)"
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)/py2"
$(eval $(call PyPackage,updater-ng-py2-supervisor))
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)/py3"
$(eval $(call Py3Package,updater-ng-py3-supervisor))
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)"

$(eval $(call BuildPackage,updater-ng))
$(eval $(call BuildPackage,updater-ng-supervisor))
$(eval $(call BuildPackage,updater-ng-py2-supervisor))
$(eval $(call BuildPackage,updater-ng-py3-supervisor))
$(eval $(call BuildPackage,updater-ng-localrepo))
$(eval $(call BuildPackage,updater-ng-opkg))
$(eval $(call BuildPackage,opkg-trans))
$(eval $(call BuildPackage,updater))
$(eval $(call BuildPackage,updater-ng-migration-helper))
$(eval $(call HostBuild))
