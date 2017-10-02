#
# Copyright (C) 2012-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=reptyr
PKG_VERSION:=0.6.2
PKG_RELEASE:=1
PKG_SOURCE_PROTO:=git

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=COPYING

PKG_SOURCE_URL:=https://github.com/nelhage/reptyr.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=reptyr-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/reptyr
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Tool for reparenting running programs
  URL:=https://github.com/nelhage/reptyr
  DEPENDS:=@i386||x86_64||arm
endef

define Package/reptyr/description
  reptyr is a utility for taking an existing running program and attaching it
  to a new terminal. Started a long-running process over ssh, but have to
  leave and don't want to interrupt it? Just start a screen, use reptyr to
  grab it, and then kill the ssh session and head on home.
endef

MAKE_FLAGS+= \
	PREFIX=/usr

define Package/reptyr/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/reptyr $(1)/usr/bin/
endef

$(eval $(call BuildPackage,reptyr))
