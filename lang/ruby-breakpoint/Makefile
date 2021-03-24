#
## Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=ruby-breakpoint
PKG_VERSION:=2.7.1
PKG_RELEASE:=1
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

HOST_BUILD_DEPENDS:=ruby/host
PKG_BUILD_DEPENDS:=ruby-dev

include $(INCLUDE_DIR)/host-build.mk
include $(INCLUDE_DIR)/package.mk

Build/Compile:=:
Host/Compile:=:

define Host/Install
	$(STAGING_DIR_HOSTPKG)/bin/gem install breakpoint -v $(PKG_VERSION)
endef

$(eval $(call HostBuild))
$(eval $(call Build/DefaultTargets))
