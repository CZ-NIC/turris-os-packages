include $(TOPDIR)/rules.mk

PKG_NAME:=lmdb
PKG_VERSION:=0.9.23
PKG_RELEASE:=1

PKG_SOURCE:=LMDB_$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/LMDB/lmdb/tar.gz/LMDB_$(PKG_VERSION)?
PKG_HASH:=abf42e91f046787ed642d9eb21812a5c473f3ba5854124484d16eadbe0aa9c81
PKG_BUILD_DIR:=$(BUILD_DIR)/lmdb-LMDB_$(PKG_VERSION)
MAKE_PATH:=libraries/liblmdb

PKG_MAINTAINER:=Jan Pavlinec <jan.pavlinec@nic.cz>
PKG_LICENSE:=OLDAP-2.8
PKG_LICENSE_FILES:=LICENSE

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/lmdb/Default
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Lightning Memory-Mapped Database
  URL:=https://symas.com/lmdb/
endef

define Package/lmdb
	$(call Package/lmdb/Default)
	TITLE+= shared library
endef

define Package/lmdb/description
  LMDB is an ultra-fast, ultra-compact key-value
  embedded data store developed for the OpenLDAP Project.
endef

define Package/lmdb-utils
	$(call Package/lmdb/Default)
	TITLE+= utils
endef

define Package/lmdb-utils/description
  LMDB environment status and copy tool
endef

define Package/lmdb-test
	$(call Package/lmdb/Default)
	TITLE+= test
endef

define Package/lmdb-test/description
  LMDB test application
endef

TARGET_CFLAGS += $(FPIC)

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR)/$(MAKE_PATH) \
		CC="$(TARGET_CC)" \
		CFLAGS+="$(TARGET_CFLAGS)" \
		LDFLAGS+="$(TARGET_LDFLAGS)"
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/$(MAKE_PATH)/lmdb.h $(1)/usr/include
	$(CP) $(PKG_BUILD_DIR)/$(MAKE_PATH)/liblmdb.a $(1)/usr/lib
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig/
	$(CP) $(PKG_BUILD_DIR)/liblmdb.pc $(1)/usr/lib/pkgconfig/lmdb.pc
endef

define Package/lmdb/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/$(MAKE_PATH)/*.so  $(1)/usr/lib/
endef

define Package/lmdb-utils/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/$(MAKE_PATH)/mdb_{stat,copy,dump,load} $(1)/usr/bin
endef

define Package/lmdb-test/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/$(MAKE_PATH)/mtest $(1)/usr/bin
endef

$(eval $(call BuildPackage,lmdb))
$(eval $(call BuildPackage,lmdb-utils))
$(eval $(call BuildPackage,lmdb-test))
