include $(TOPDIR)/rules.mk

PKG_NAME:=lmdb
PKG_VERSION:=0.9.23
PKG_RELEASE:=1

PKG_SOURCE:=LMDB_$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/LMDB/lmdb/tar.gz/LMDB_$(PKG_VERSION)?
PKG_HASH:=abf42e91f046787ed642d9eb21812a5c473f3ba5854124484d16eadbe0aa9c81
PKG_SOURCE_SUBDIR:=lmdb-LMDB_$(PKG_VERSION)
PKG_BUILD_DIR:=$(BUILD_DIR)/lmdb-LMDB_$(PKG_VERSION)
MAKE_PATH:=libraries/liblmdb

PKG_INSTALL:=1
PKG_LICENSE:=OpenLDAP Public License
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:= Jan Pavlinec <jan.pavlinec@nic.cz>

include $(INCLUDE_DIR)/package.mk

define Package/lmdb/Default
	SECTION:=libs
	CATEGORY:=Libraries
	TITLE:=Lightning Memory-Mapped Database
	URL:=https://symas.com/lmdb/
endef

TARGET_CFLAGS+=-fPIC

define Package/liblmdb0
	$(call Package/lmdb/Default)
	TITLE+= mdb0
endef

define Package/liblmdb0/description
	Lightning Memory-Mapped Database.
endef

define Package/lmdb-utils
	$(call Package/lmdb/Default)
	TITLE+= utils
endef

define Package/lmdb-utils/description
	Lightning Memory-Mapped Database.
endef

define Package/lmdb-test
	$(call Package/lmdb/Default)
	TITLE+= test
endef

define Package/lmdb-test/description
	Lightning Memory-Mapped Database.
endef

define Build/Prepare
	$(PKG_UNPACK)
	(cd $(PKG_BUILD_DIR) && mv libraries/liblmdb/* . && rm -rf libraries )
	$(Build/Patch)
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR)/$(MAKE_PATH) \
				CC="$(TARGET_CC)" \
				CFLAGS+="$(TARGET_CFLAGS)" \
				LDFLAGS+="$(TARGET_LDFLAGS)"
endef


define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/lmdb.h $(1)/usr/include
	$(CP) $(PKG_BUILD_DIR)/liblmdb.a $(1)/usr/lib
endef

define Package/liblmdb0/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/libraries/liblmdb/*.so*  $(1)/usr/lib
endef

define Package/lmdb-utils/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mdb_stat $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mdb_copy $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mdb_dump $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mdb_load $(1)/usr/bin
endef

define Package/lmdb-test/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mtest $(1)/usr/bin
endef

$(eval $(call BuildPackage,liblmdb0))
$(eval $(call BuildPackage,lmdb-utils))
$(eval $(call BuildPackage,lmdb-test))
