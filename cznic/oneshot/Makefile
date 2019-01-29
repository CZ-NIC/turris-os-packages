#
## Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=oneshot
PKG_VERSION:=0
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
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
	$(INSTALL_BIN) ./files/oneshot.sh $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/usr/share/oneshot/scripts
	for s in ./files/scripts/* ; do $(INSTALL_BIN) "$$$$s" $(1)/usr/share/oneshot/scripts ; done
	$(INSTALL_DIR) $(1)/usr/share/oneshot/completed
	touch $(1)/usr/share/oneshot/completed/.keep
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh

if [ -z "$${IPKG_INSTROOT}" ] ; then
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
