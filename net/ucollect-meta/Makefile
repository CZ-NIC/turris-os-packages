#
## Copyright (C) 2014 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=ucollect-meta
PKG_VERSION:=3
PKG_MAINTAINER:=Michal Vaner <michal.vaner@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+ucollect-badconf +ucollect-bandwidth +ucollect-buckets +ucollect-count +ucollect-flow +ucollect-sniff +ucollect-spoof +ucollect-refused
endef

define Build/Compile
	true
endef

define Package/$(PKG_NAME)/install
	true
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
