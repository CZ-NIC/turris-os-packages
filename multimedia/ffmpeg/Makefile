#
# Copyright (C) 2006-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ffmpeg
PKG_VERSION:=4.0.5
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://ffmpeg.org/releases/
PKG_HASH:=13f258aa54e181cb3c49e35c12ab842f05e3b1d1588100567b2e53ebb0ef3972

PKG_MAINTAINER:=Ted Hess <thess@kitschensync.net>
PKG_LICENSE:=LGPL-2.1+ GPL-2+ LGPL-3
PKG_LICENSE_FILES:=COPYING.GPLv2 COPYING.GPLv3 COPYING.LGPLv2.1 COPYING.LGPLv3

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/ffmpeg/Default
 TITLE:=FFmpeg
 URL:=https://www.ffmpeg.org/
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

# Strip off FPU notation
REAL_CPU_TYPE:=$(firstword $(subst +, ,$(CONFIG_CPU_TYPE)))
# Fixup cpu types recogized by ffmpeg configure
REAL_CPU_TYPE:=$(subst octeonplus,octeon+,$(REAL_CPU_TYPE))

FFMPEG_CONFIGURE:= \
	CFLAGS="$(TARGET_CFLAGS) $(TARGET_CPPFLAGS) $(FPIC)" \
	LDFLAGS="$(TARGET_LDFLAGS)" \
	./configure \
	--enable-cross-compile \
	--cross-prefix="$(TARGET_CROSS)" \
	--arch="$(ARCH)" \
	$(if $(REAL_CPU_TYPE),--cpu=$(call qstrip,$(REAL_CPU_TYPE)),) \
	--target-os=linux \
	--prefix="/usr" \
	--pkg-config="pkg-config" \
	--enable-shared \
	--enable-static \
	--enable-pthreads \
	--enable-zlib \
	--disable-doc \
	--disable-debug \
	--enable-gpl \
	--enable-version3 \
	\
	--disable-lzma \
	--disable-vaapi \
	--disable-vdpau \
	--disable-outdevs \
	--enable-avresample

ifeq ($(CONFIG_SOFT_FLOAT),y)
FFMPEG_CONFIGURE+= \
	--disable-altivec \
	--disable-vsx \
	--disable-power8 \
	--disable-armv5te \
	--disable-armv6 \
	--disable-armv6t2 \
	--disable-inline-asm \
	--disable-mipsdsp \
	--disable-mipsdspr2 \
	--disable-mipsfpu \
	--disable-msa \
	--disable-mmi \
	--disable-fast-unaligned \
	--disable-runtime-cpudetect

else ifneq ($(findstring arm,$(CONFIG_ARCH)),)
FFMPEG_CONFIGURE+= \
	--disable-runtime-cpudetect
# XXX: GitHub issue 3320 ppc cpu with fpu but no altivec (WNDR4700)
else ifneq ($(findstring powerpc,$(CONFIG_ARCH)),)
FFMPEG_CONFIGURE+= \
	--disable-altivec
endif

# libavcodec/mips/aacdec_mips.c build problem
# XXX: disable use of assembly on MIPS. Patches welcome.
ifneq ($(findstring mips,$(CONFIG_ARCH)),)
FFMPEG_CONFIGURE+= \
        --disable-asm --disable-inline-asm
endif

# selectively disable optimizations according to arch/cpu type
ifneq ($(findstring arm,$(CONFIG_ARCH)),)
	FFMPEG_CONFIGURE+= --enable-lto

	ifneq ($(findstring vfp,$(CONFIG_TARGET_OPTIMIZATION)),)
		FFMPEG_CONFIGURE+= --enable-vfp
	else
		FFMPEG_CONFIGURE+= --disable-vfp
	endif
	ifneq ($(findstring neon,$(CONFIG_TARGET_OPTIMIZATION)),)
		FFMPEG_CONFIGURE+= \
			--enable-neon \
			--enable-vfp
	else
		FFMPEG_CONFIGURE+= --disable-neon
	endif
endif

ifeq ($(ARCH),x86_64)
	FFMPEG_CONFIGURE+= --enable-lto
endif

ifneq ($(CONFIG_TARGET_x86),)
ifeq ($(CONFIG_NASM),y)
  FFMPEG_CONFIGURE += --enable-x86asm
else
  FFMPEG_CONFIGURE += --disable-x86asm
endif
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
