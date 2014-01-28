#
## Copyright (C) 2014 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=getbranch
PKG_VERSION:=2
PKG_MAINTAINER:=Michal Vaner <michal.vaner@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Build/Compile
	true
endef

define BRANCH
define Package/getbranch-$(1)
	TITLE:=getbranch-$(1)
endef

define Package/getbranch-$(1)/install
	$$(INSTALL_DIR) $$(1)/usr/bin
	echo '#!/bin/sh' >$$(1)/usr/bin/getbranch
	echo 'echo $(1)' >>$$(1)/usr/bin/getbranch
	chmod 0555 $$(1)/usr/bin/getbranch
endef
$$(eval $$(call BuildPackage,getbranch-$(1)))

endef

$(eval $(call BRANCH,test))
$(eval $(call BRANCH,master))
$(eval $(call BRANCH,deploy))
