#
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=gpgme
PKG_VERSION:=1.4.3
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=ftp://ftp.gnupg.org/gcrypt/gpgme/
PKG_MD5SUM:=334e524cffa8af4e2f43ae8afe585672

PKG_INSTALL:=1

PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk

define Package/libgpgme
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=GnuPG Made Easy library
  DEPENDS:=+gnupg +libassuan +libpthread
  URL:=http://www.gnupg.org/
endef

define Package/libgpgme/description
  GnuPG Made Easy (GPGME) is a library designed to make access to GnuPG easier for 
  applications. It provides a High-Level Crypto API for encryption, decryption, signing, 
  signature verification and key management. Currently it uses GnuPG as its backend but 
  the API isn't restricted to this engine; in fact we have already developed a backend 
  for CMS (S/MIME).
endef

ifdef CONFIG_USE_UCLIBC
CONFIGURE_VARS += \
    LIBS="-largp"
endif

CONFIGURE_ARGS += \
	--enable-shared \
	--enable-static \
	--with-gpg=/"usr/bin/gpg" \
	--with-gpg-error-prefix="$(STAGING_DIR)/usr" \
	--with-libassuan-prefix="$(STAGING_DIR)/usr" \
	--without-g13 \
	--without-gpgconf \
	--without-gpgsm \
	--without-pth \

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/gpgme.h $(1)/usr/include/

	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libgpgme{,-pthread}.{a,so*} $(1)/usr/lib/
endef

define Package/libgpgme/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libgpgme{,-pthread}.so.* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libgpgme))
