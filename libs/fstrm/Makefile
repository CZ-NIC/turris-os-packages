
include $(TOPDIR)/rules.mk

PKG_NAME:=fstrm
PKG_VERSION:=0.5.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/farsightsec/fstrm/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=ca762fb260176f35af639376cc65c3f13a5f63d1cca42eb5ce87caca8d57c450

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=COPYRIGHT
PKG_MAINTAINER:=

PKG_FIXUP:=autoreconf
PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk


define Package/fstrm
  URL:=https://github.com/farsightsec/fstrm
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Frame Streams data transport protocol
  DEPENDS:=+libevent2
endef

define Package/fstrm/description
  Frame Streams is a light weight, binary clean protocol that allows
  for the transport of arbitrarily encoded data payload sequences
  with minimal framing overhead.
endef

TARGET_CFLAGS += --std=c99

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/* $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libfstrm.{a,so*} $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/libfstrm.pc $(1)/usr/lib/pkgconfig
endef

define Package/fstrm/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/fstrm_capture $(1)/usr/bin/
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/fstrm_dump $(1)/usr/bin/
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/fstrm_replay $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libfstrm.so.* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,fstrm))
