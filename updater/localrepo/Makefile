#
## Copyright (C) 2019-2020 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=localrepo
PKG_VERSION:=0.2.1
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/updater/localrepo.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=MIT

include $(INCLUDE_DIR)/package.mk

define Package/localrepo
  SECTION:=updater
  CATEGORY:=Turris Updater
  TITLE:=Updater local repository manager
  DEPENDS:=+python3-light
endef

define Package/localrepo/description
  Localrepo is script for managing local repository. This is solution for out of
  tree packages installation of packages for updater-ng. Updater-ng can track and
  keep in system only packages that are in some configured repository. By creating
  local repository user can inject any arbitrary package to updater-ng.
endef

define Package/localrepo/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/localrepo $(1)/usr/bin/localrepo
	$(INSTALL_DIR) $(1)/etc/updater/conf.d
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/localrepo.lua $(1)/etc/updater/conf.d/localrepo.lua
endef

# Repository should be consistent when updater is executed successfully but this
# ensures that we will fix any problems that can be caused by older version of
# localrepo
define Package/localrepo/postinst
[ -n "$$IPKG_INSTROOT" ] || localrepo check --fix
endef

Build/Compile:=

$(eval $(call BuildPackage,localrepo))
