#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=mpc
PKG_VERSION:=0.31
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://www.musicpd.org/download/mpc/0
PKG_HASH:=62373e83a8a165b2ed43967975efecd3feee530f4557d6b861dd08aa89d52b2d

PKG_LICENSE:=GPL-2.0+
PKG_LICENSE_FILES:=COPYING
PKG_MAINTAINER:=Ted Hess <thess@kitschensync.net>

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/mpc
  SECTION:=sound
  CATEGORY:=Sound
  DEPENDS:=+libmpdclient
  TITLE:=Music Player Daemon Console Client
  URL:=http://www.musicpd.org/
endef

define Package/mpc/description
	MPD is a music player supporting flac, mp3 and ogg files.
	It is typically controlled over a network using one of it's many
	clients including mpc(console), gmpc(gnome), phpmp(php) etc.
	this is MPC
endef

CONFIGURE_ARGS+= --disable-iconv
TARGET_CFLAGS+= -std=gnu99

# Newer sources require meson/ninja to build so...
# Use our hacked-up version of the mpc v0.28 autotools.
define Build/Prepare
	$(call Build/Prepare/Default)
	$(CP) ./autotools-files/* $(PKG_BUILD_DIR)/
endef

define Package/mpc/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/mpc $(1)/usr/bin/
	$(INSTALL_BIN) ./files/pls-handler.sh $(1)/usr/bin/
endef

$(eval $(call BuildPackage,mpc))
