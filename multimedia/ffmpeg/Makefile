#
# Copyright (C) 2006-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ffmpeg
PKG_VERSION:=4.0.2
PKG_RELEASE:=0

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=http://ffmpeg.org/releases/
PKG_MD5SUM:=ae0bfdf809306a212b4f0e6eb8d1c75e
PKG_MAINTAINER:=Ted Hess <thess@kitschensync.net>

PKG_LICENSE:=LGPL-2.1+ GPL-2+ LGPL-3
PKG_LICENSE_FILES:=COPYING.GPLv2 COPYING.GPLv3 COPYING.LGPLv2.1 COPYING.LGPLv3

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/ffmpeg/Default
 TITLE:=FFmpeg
 URL:=http://ffmpeg.mplayerhq.hu/
endef

define Package/ffmpeg/Default/description
 FFmpeg is a a software package that can record, convert and stream digital
 audio and video in numerous formats.
endef

define Package/ffmpeg
$(call Package/ffmpeg/Default)
 SECTION:=multimedia
 CATEGORY:=Multimedia
 TITLE+= program
 DEPENDS+= +libpthread +libffmpeg
 VARIANT:=full
endef

define Package/ffmpeg/description
$(call Package/ffmpeg/Default/description)
 .
 This package contains the FFmpeg command line tool.
endef


define Package/ffprobe
$(call Package/ffmpeg/Default)
 SECTION:=multimedia
 CATEGORY:=Multimedia
 TITLE+= CLI media identifier
 DEPENDS+= +libffmpeg
 VARIANT:=full
endef

define Package/ffprobe/description
$(call Package/ffmpeg/Default/description)
 .
 This package contains the FFprobe command line tool.
endef

define Package/libffmpeg
$(call Package/ffmpeg/Default)
 SECTION:=libs
 CATEGORY:=Libraries
 TITLE+= libraries (full)
 DEPENDS+= +libpthread +zlib +libbz2 +libspeex +alsa-lib +LIBC_USE_MUSL:libfreetype
 PROVIDES:= libffmpeg-mini libffmpeg-full libffmpeg-custom libffmpeg-audio-dec
 VARIANT:=full
endef

define Package/libffmpeg/description
$(call Package/ffmpeg/Default/description)
 .
 This package contains full-featured FFmpeg shared libraries.
endef

FFMPEG_CONFIGURE:= \
	CFLAGS="$(TARGET_CFLAGS) $(TARGET_CPPFLAGS) $(FPIC)" \
	LDFLAGS="$(TARGET_LDFLAGS)" \
	./configure \
	--enable-cross-compile \
	--cross-prefix="$(TARGET_CROSS)" \
	--arch="$(ARCH)" \
	--target-os=linux \
	--prefix="/usr" \
	--pkg-config="pkg-config" \
	--enable-shared \
	--enable-static \
	--enable-small \
	--enable-pthreads \
	--enable-zlib \
	--disable-runtime-cpudetect \
	--disable-doc \
	--disable-debug \
	\
	--enable-gpl \
	--enable-version3 \
	\
	--disable-altivec \
	--disable-amd3dnow \
	--disable-amd3dnowext \
	--disable-asm \
	--disable-mmx \
	--disable-mmxext \
	--disable-sse \
	--disable-sse2 \
	--disable-sse3 \
	--disable-ssse3 \
	--disable-sse4 \
	--disable-sse42 \
	--disable-avx \
	--disable-xop \
	--disable-fma3 \
	--disable-fma4 \
	--disable-avx2 \
	--disable-inline-asm \
	--disable-yasm \
	--disable-mips32r2 \
	--disable-mipsdspr2 \
	--disable-mipsfpu \
	\
	--disable-dxva2 \
	--disable-lzma \
	--disable-vaapi \
	--disable-vdpau \
	--enable-outdev=fbdev \
	--enable-avresample

ifeq ($(CONFIG_LIBC_USE_MUSL),y)
FFMPEG_CONFIGURE+= \
	--enable-libfreetype
else
FFMPEG_CONFIGURE+= \
	--disable-libfreetype
endif

ifeq ($(CONFIG_TARGET_mvebu),)
FFMPEG_CONFIGURE+= \
	--disable-vfp \
	--disable-neon
else
FFMPEG_CONFIGURE+= \
	--enable-vfp \
	--enable-neon
endif

ifneq ($(CONFIG_TARGET_x86),)
  TARGET_CFLAGS += -fomit-frame-pointer
endif

define Build/Configure
	( cd $(PKG_BUILD_DIR); $(FFMPEG_CONFIGURE) )
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		all install
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/lib{avcodec,avdevice,avfilter,avformat,avresample,avutil,postproc,swresample,swscale} $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/lib{avcodec,avdevice,avfilter,avformat,avresample,avutil,postproc,swresample,swscale}.{a,so*} $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/lib{avcodec,avdevice,avfilter,avformat,avresample,avutil,postproc,swresample,swscale}.pc $(1)/usr/lib/pkgconfig/
endef

define Package/ffmpeg/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/ffmpeg $(1)/usr/bin/
endef

define Package/ffprobe/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/ffprobe $(1)/usr/bin/
endef

define Package/libffmpeg/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/lib{avcodec,avdevice,avfilter,avformat,avresample,avutil,postproc,swresample,swscale}.so.* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,ffmpeg))
$(eval $(call BuildPackage,ffprobe))
$(eval $(call BuildPackage,libffmpeg))
