include $(TOPDIR)/rules.mk

PKG_NAME:=libotr
PKG_VERSION:=3.2.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.cypherpunks.ca/otr/
PKG_MD5SUM:=974acf937d2ce0ee89b27a9815c17a3f

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libotr
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=OTR Messaging Library
  URL:=http://www.cypherpunks.ca/otr/
  DEPENDS:=+libgcrypt
  MAINTAINER:=Peter Wagner <tripolar@gmx.at>
endef

define Package/libotr/description
  Off-the-Record (OTR) Messaging allows you to have private conversations over
  instant messaging.
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		CC='$(TARGET_CC) $(FPIC)' \
		CFLAGS='$(TARGET_CFLAGS) -Wall -D_GNU_SOURCE' \
		LDFLAGS='$(TARGET_LDFLAGS)' \
		all
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include $(1)/usr/lib $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/include/libotr $(1)/usr/include/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libotr.{a,la,so*} $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/libotr.pc $(1)/usr/lib/pkgconfig/
endef

define Package/libotr/install
	$(INSTALL_DIR) $(1)/usr/lib $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libotr.so.* $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin
endef

$(eval $(call BuildPackage,libotr))
