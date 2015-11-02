# 
# Copyright (C) 2006-2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=mplayer
PKG_VERSION:=1.0rc3
PKG_RELEASE:=1

PKG_SOURCE:=MPlayer-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://www.mplayerhq.hu/MPlayer/releases/
PKG_BUILD_DIR=$(BUILD_DIR)/MPlayer-$(PKG_VERSION)
PKG_MD5SUM:=e1221be5fcad74a2a4185f67ba6c9ae0

include $(INCLUDE_DIR)/package.mk

define Package/mplayer
  SECTION:=sound
  CATEGORY:=Sound
  TITLE:=MPlayer
  URL:=http://www.mplayerhq.hu/
  DEPENDS:=+alsa-lib +libbz2 +libjpeg +liblzo +libncurses +libpng +libpthread +libspeex +zlib
endef

define Package/mplayer/description
MPlayer can play most standard video formats out of the box
and almost all others with the help of external codecs.
endef

CONFIGURE_ARGS = \
	--target=$(GNU_TARGET_NAME) \
	--prefix=/usr \
	--disable-mencoder \
	--disable-vidix \
	--disable-vm \
	--disable-dvdnav \
	--disable-dvdread \
	--disable-dvdread-internal \
	--disable-libdvdcss-internal \
	--disable-pvr \
	--disable-tv \
	--disable-v4l2 \
	--disable-tv-v4l1 \
	--disable-tv-v4l2 \
	--disable-dvb \
	--disable-xanim \
	--disable-win32dll \
	--disable-dvb \
	--disable-yuv4mpeg \
	--disable-pnm \
	--disable-tga \
	--enable-fbdev \
	--enable-static \

define Package/mplayer/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mplayer $(1)/usr/bin/
endef

$(eval $(call BuildPackage,mplayer))
