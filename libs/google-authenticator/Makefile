# 
# Copyright (C) 2006-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=google-authenticator
PKG_REV:=a096a628455a
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=http://code.google.com/p/google-authenticator/
PKG_SOURCE_VERSION:=$(PKG_REV)

include $(INCLUDE_DIR)/package.mk

define Package/libpam-google-authenticator
  SECTION:=libs
  CATEGORY:=Libraries
  DEPENDS:=+libpam +libqrencode
  TITLE:=Googles 2-step verification PAM library
  URL:=http://code.google.com/p/google-authenticator/
endef

define Package/libpam-google-authenticator/description
The Google Authenticator project includes implementations of one-time
passcode generators for several mobile platforms, as well as a pluggable
authentication module (PAM). One-time passcodes are generated using open
standards developed by the Initiative for Open Authentication (OATH)
(which is unrelated to OAuth).

These implementations support the HMAC-Based One-time Password (HOTP)
algorithm specified in RFC 4226 and the Time-based One-time Password
(TOTP) algorithm specified in RFC 6238. 
endef

define Build/Configure
endef

TARGET_CFLAGS+= -I$(STAGING_DIR)/usr/include
TARGET_LDFLAGS+= -s

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR)/libpam \
		$(TARGET_CONFIGURE_OPTS) \
		CFLAGS="$(TARGET_CFLAGS)" \
		LDFLAGS="$(TARGET_LDFLAGS)" \
		all
endef

define Package/libpam-google-authenticator/install
	$(INSTALL_DIR) $(1)/usr/sbin $(1)/lib/security
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/libpam/google-authenticator $(1)/usr/sbin/
	$(CP) $(PKG_BUILD_DIR)/libpam/pam_google_authenticator.so $(1)/lib/security/
endef

$(eval $(call BuildPackage,libpam-google-authenticator))
