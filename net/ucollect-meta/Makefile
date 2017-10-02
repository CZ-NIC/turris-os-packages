#
## Copyright (C) 2014-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=ucollect-meta
PKG_VERSION:=6
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

# TODO: remove +ip6tables +iptables from DEPENDS and figure out why OpenWRT thinks there is a circular dependency

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+ucollect-badconf +ucollect-bandwidth +ucollect-count +ucollect-flow +ucollect-sniff +ucollect-spoof +ucollect-refused +ucollect-fake +ucollect-fwup +ip6tables +iptables
endef

define Build/Compile
	true
endef

define Package/$(PKG_NAME)/install
	true
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
