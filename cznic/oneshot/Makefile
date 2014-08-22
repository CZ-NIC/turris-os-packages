#
## Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=oneshot
PKG_VERSION:=11
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/misc.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=3fbb9d55df0133305db8be387b749bc9d46a8979
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Michal Vaner <michal.vaner@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
endef

# The built is empty. But as there's no makefile in the git repo, we need to
# override the default that runs "make".
define Build/Compile
	true
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/oneshot/oneshot.sh $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/usr/share/oneshot/scripts
	$(INSTALL_DIR) $(1)/usr/share/oneshot/completed
	for s in $(PKG_BUILD_DIR)/oneshot/scripts/* ; do $(INSTALL_BIN) "$$$$s" $(1)/usr/share/oneshot/scripts ; done
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh

if [ -z "$${IPKG_INSTROOT}" ] ; then
	if -f /usr/share/oneshot/completed/scripts ; then
		# Workaround. We didn't create the right scripts when it was being distributed.
		# So add them now
		cd /usr/share/oneshot/completed
		touch 0000-opkg-uri 0002-opkg-https 0001-opkg-no-testing 0003-reset-updater-pkgs
	fi
	# If we are directly on the device, the variable is empty. Run right away.
	/usr/bin/oneshot.sh
else
	# If it's on the device, then we already set up everything as it should be.
	# Pretend all the scripts available now were already run.
	for s in "$${IPKG_INSTROOT}"/usr/share/oneshot/scripts/* ; do
		touch "$${IPKG_INSTROOT}"/usr/share/oneshot/completed/$$(basename "$$s")
	done
fi
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
